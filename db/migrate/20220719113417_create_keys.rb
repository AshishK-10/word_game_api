class CreateKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :keys do |t|
      t.string  :name
      t.integer :count 
      t.timestamps
      t.belongs_to :user, index: true,foreign_key: true
    end
  end
end
