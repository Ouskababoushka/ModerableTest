class AddTitleToModeratedModel < ActiveRecord::Migration[7.0]
  def change
    add_column :moderated_models, :title, :string
  end
end
