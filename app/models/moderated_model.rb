class ModeratedModel < ApplicationRecord
  include Moderable
  before_save :moderate_content

  self.moderated_columns = [:title, :content]
end
