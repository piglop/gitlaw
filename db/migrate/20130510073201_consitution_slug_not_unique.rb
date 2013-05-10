class ConsitutionSlugNotUnique < ActiveRecord::Migration
  def up
    remove_index :texts, :slug
    add_index :texts, :slug
  end

  def down
    remove_index :texts, :slug
    add_index :texts, :slug, unique: true
  end
end
