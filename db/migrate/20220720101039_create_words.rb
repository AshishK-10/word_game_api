class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.string :word
      t.text :defination, array: true
      t.text :example, array: true
      t.text :relationshipType, array: true
      t.timestamps
    end
  end
end
