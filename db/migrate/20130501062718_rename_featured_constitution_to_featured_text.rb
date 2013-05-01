class RenameFeaturedConstitutionToFeaturedText < ActiveRecord::Migration
  def up
    rename_table :featured_constitutions, :featured_texts
    rename_column :featured_texts, :constitution_id, :text_id
  end
  
  def down
    rename_column :featured_texts, :text_id, :constitution_id
    rename_table :featured_texts, :featured_constitutions
  end
end
