class ModeratedModel < ApplicationRecord
  include Moderable

  def moderated_columns
    self.moderated_columns = [:title, :content]
  end
end

# On déclare ici les columns qui seront testé par notre module.
