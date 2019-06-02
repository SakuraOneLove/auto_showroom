class CreateBodies < ActiveRecord::Migration[5.2]
  def change
    create_table :bodies do |t|
      t.string :name
      t.string :material
      t.integer :length #длина в мм
      t.integer :width  #так же как и ширина в мм

      t.timestamps
    end
  end
end
