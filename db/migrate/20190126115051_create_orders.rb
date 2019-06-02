class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :amount #количество машин в заказе
      t.string :type_of_pay
      t.string :delivery  #вид доставки
      t.string :colour
      t.integer :final_price
      t.integer :extended_id
      t.integer :customer_id
      t.integer :product_id
      t.timestamps
    end
  end
end
