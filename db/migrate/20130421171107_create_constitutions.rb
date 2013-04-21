class CreateConstitutions < ActiveRecord::Migration
  def change
    create_table :constitutions do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
