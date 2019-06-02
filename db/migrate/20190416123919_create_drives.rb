class CreateDrives < ActiveRecord::Migration[5.2]
  def change
    create_table :drives do |t|
      t.string :name
      t.integer :weight
      t.string :manuf

      t.timestamps
    end
  end
end
