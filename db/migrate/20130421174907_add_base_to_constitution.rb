class AddBaseToConstitution < ActiveRecord::Migration
  def change
    add_column :constitutions, :base_id, :integer
    add_index :constitutions, :base_id
  end
end
