class Product < ApplicationRecord
  has_many :orders
  belongs_to :tech
  belongs_to :body
  belongs_to :brand

  def self.row_exist?(model)
    p = Product.find_by_sql("SELECT id FROM products WHERE model = '#{model}' LIMIT 1")
    !p.empty?
  end

  def self.add_row(model,exist,image,price,brand)
    sql = "INSERT INTO products (model,exist,image,price,fav,tech_id,body_id,brand_id, created_at, updated_at)
     VALUES ('#{model}','#{exist}','#{image}',#{price},'0',(SELECT id FROM teches ORDER BY id DESC LIMIT 1),(SELECT id FROM bodies ORDER BY id DESC LIMIT 1),(SELECT id FROM brands WHERE name = '#{brand}'),'#{Time.now.to_s}','#{Time.now.to_s}')"
    ActiveRecord::Base.connection.execute(sql) # com_query
  end

  def self.update_row(id,model,exist,image,price)
    sql = "UPDATE products SET model = '#{model}', exist = '#{exist}', image = '#{image}', price = #{price} WHERE id = #{id}"
    ActiveRecord::Base.connection.execute(sql)
  end
end
