# таблица с авто
class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :model
      t.string :exist
      t.string :image
      t.float :price
      t.boolean :fav  # машины класса люкс, для главной страницы
      t.integer :tech_id
      t.integer :body_id
      t.integer :brand_id
      t.timestamps
    end
  end
end
