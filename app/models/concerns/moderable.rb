require 'httparty'

module Moderable
  extend ActiveSupport::Concern

  class_methods do
    def moderated_columns
      @moderated_columns || []
    end

    def moderated_columns=(columns)
      @moderated_columns = columns
    end
  end

  def moderate_content
    self.class.moderated_columns.each do |column|
      content = send(column)
      next if content.blank?

      response = HTTParty.get("https://moderation.logora.fr/predict?text=#{content}")
      # p JSON.parse(response.body)
      if response.code == 200
        prediction = JSON.parse(response.body)["prediction"]["0"]
        update(is_accepted: prediction > 0.5)
      else
        errors.add(column, "Unable to moderate content")
      end
    end
  end
end
