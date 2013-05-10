class AddHeadToText < ActiveRecord::Migration
  def change
    add_column :texts, :head, :string
  end
end
