class AddIsAcceptedToModeratedModel < ActiveRecord::Migration[7.0]
  def change
    add_column :moderated_models, :is_accepted, :boolean, default: false
  end
end
