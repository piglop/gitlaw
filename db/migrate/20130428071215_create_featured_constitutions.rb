class CreateFeaturedConstitutions < ActiveRecord::Migration
  def change
    create_table :featured_constitutions do |t|
      t.belongs_to :constitution

      t.timestamps
    end
    add_index :featured_constitutions, :constitution_id
  end
end
