class AddContentToModeratedModel < ActiveRecord::Migration[7.0]
  def change
    add_column :moderated_models, :content, :string
  end
end
