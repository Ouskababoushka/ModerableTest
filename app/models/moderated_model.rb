class ModeratedModel < ApplicationRecord
  include Moderable

  def moderated_columns
    self.moderated_columns = [:title, :content]
  end
end
