class RenameConstitutionIndexes < ActiveRecord::Migration
  def change
    rename_index :featured_texts, 'index_featured_constitutions_on_constitution_id', 'index_featured_texts_on_text_id'
    rename_index :texts, 'index_constitutions_on_base_id', 'index_text_on_base_id'
    rename_index :texts, 'index_constitutions_on_slug', 'index_texts_on_slug'
    rename_index :texts, 'index_constitutions_on_user_id', 'index_texts_on_user_id'
  end
end
