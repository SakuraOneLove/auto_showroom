class CreateTypengs < ActiveRecord::Migration[5.2]
  def change
    create_table :typengs do |t|
      t.string :name
      t.string :kind  #тип двигателя: бензиновый, дизельный и т.д.
      t.string :material
      t.integer :cyls #количество цилиндров
      t.float :val_engine
      t.float :power  #мощность двигателя

      t.timestamps
    end
  end
end
