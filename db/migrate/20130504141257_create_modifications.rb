class CreateModifications < ActiveRecord::Migration
  def change
    create_table :modifications do |t|
      t.belongs_to :user
      t.belongs_to :original
      t.string :title
      t.text :motivations
      t.text :text

      t.timestamps
    end
    add_index :modifications, :user_id
    add_index :modifications, :original_id
  end
end
