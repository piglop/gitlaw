class RenameConstitutionToText < ActiveRecord::Migration
  def change
    rename_table :constitutions, :texts
  end
end
