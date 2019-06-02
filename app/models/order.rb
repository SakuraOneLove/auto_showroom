class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  belongs_to :extended

  def self.add_row(p_id, c_id, pay, delivery, col, ex_id, amount)
    car_price = Product.find_by_sql("SELECT price from products WHERE id = #{p_id}")[0].price + Extended.get_price(ex_id) 
    sql = "INSERT INTO orders (amount,type_of_pay,delivery,colour,final_price,extended_id,customer_id,product_id, created_at, updated_at)
     VALUES (#{amount},'#{pay}','#{delivery}','#{col}',#{car_price},#{ex_id},#{c_id},#{p_id},'#{Time.now.to_s}','#{Time.now.to_s}')"
    ActiveRecord::Base.connection.execute(sql)
  end

  def self.update_row(id,amount,t_pay,delivery, col, ex_id)
    curr_order = Order.find_by_sql("SELECT * FROM orders WHERE id = #{id}")[0]
    car_price = curr_order.product.price + Extended.get_price(ex_id) 
    sql = "UPDATE orders SET amount = #{amount}, type_of_pay = '#{t_pay}', delivery = '#{delivery}',final_price = #{car_price} ,colour = '#{col}', extended_id = #{ex_id} WHERE id = #{id}"
    ActiveRecord::Base.connection.execute(sql)
  end
end
