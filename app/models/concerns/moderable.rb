require 'httparty'

module Moderable
  extend ActiveSupport::Concern

  included do
    before_validation :moderate_content, on: [:create, :update], if: -> { new_record? || content_changed? || title_changed? }
    class_attribute :moderated_columns, default: []
  end

  def moderate_content
    verdict = []
    self.class.moderated_columns.each do |column|
      content = send(column)
      next if content.blank?

      response = HTTParty.get("https://moderation.logora.fr/predict?text=#{content}")
      if response.code == 200
        prediction = JSON.parse(response.body)["prediction"]["0"]
        prediction > 0.1669644832611084 ? verdict << true : verdict << false
      else
        errors.add(column, "Unable to moderate content")
      end
    end
    verdict.all? ? self.is_accepted = true : self.is_accepted = false
  end
end

# Avant la validation d'un modèle où le concern est inclus, on déclenche la méthode moderate_content
# On déclare un array Verdict qui va rassembler les booleans correspondant à chaque column du modèle.
# Pour chaque columns non vide, on rend true ou flase si la prediction > prediction de rejet (si j'ai bien compris?)
# Si notre verdict final contiens un false minimum, on rejette la création du modèle
