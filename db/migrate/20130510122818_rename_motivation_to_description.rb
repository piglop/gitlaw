class RenameMotivationToDescription < ActiveRecord::Migration
  def change
    rename_column :modifications, :motivations, :description
  end
end
