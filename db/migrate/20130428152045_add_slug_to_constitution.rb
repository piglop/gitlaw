class AddSlugToConstitution < ActiveRecord::Migration
  def change
    add_column :constitutions, :slug, :string
    add_index :constitutions, :slug, unique: true
  end
end
