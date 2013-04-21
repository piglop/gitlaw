class CreateLawTexts < ActiveRecord::Migration
  def change
    create_table :law_texts do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
