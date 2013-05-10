class AddHeadToModification < ActiveRecord::Migration
  def change
    add_column :modifications, :head, :string
  end
end
