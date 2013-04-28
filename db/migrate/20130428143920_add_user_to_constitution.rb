class AddUserToConstitution < ActiveRecord::Migration
  def change
    add_column :constitutions, :user_id, :integer
    add_index :constitutions, :user_id
  end
end
