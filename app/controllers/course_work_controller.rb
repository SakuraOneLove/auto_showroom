class CourseWorkController < ApplicationController
  def view
    @fav = Product.find_by_sql("select * from products where id < 11")
  end

  def cars
    @cars = Product.paginate(page: params[:page], per_page: 15)
  end

  def watch
    p_id = params[:param]
    sql_id = "SELECT brands.id,teches.id,typengs.id,drives.id,transmissions.id,bodies.id FROM brands,teches,typengs,drives,transmissions,bodies WHERE brands.id = (select brand_id from products where id = #{p_id}) AND teches.id = (select tech_id from products where id = #{p_id}) AND typengs.id = (select typeng_id from teches where id = (select tech_id from products where id = #{p_id})) AND drives.id = (select drive_id from teches where id = (select tech_id from products where id = #{p_id})) AND transmissions.id = (select transmission_id from teches where id = (select tech_id from products where id = #{p_id})) AND bodies.id = (select body_id from products where id = #{p_id});"
    id_arr = ActiveRecord::Base.connection.execute(sql_id)[0] # com_report
    sql = "SELECT image,model,brands.name,brands.id,racing,mspeed,way_res,num_of_doors,num_of_place,loc_of_engine,val_engine,power,cyls,kind,typengs.name,drives.name,transmissions.name,gears,bodies.name,length,width,price,products.id FROM products, brands,teches,typengs,drives,transmissions,bodies WHERE products.id = #{p_id} AND brands.id = #{id_arr[0]} AND teches.id = #{id_arr[1]} AND typengs.id = #{id_arr[2]} AND drives.id = #{id_arr[3]} AND transmissions.id= #{id_arr[4]} AND bodies.id = #{id_arr[5]};"
    @p = ActiveRecord::Base.connection.execute(sql)[0] # com_report
  end

  def l_customers; end

  def customers
    @c_id = params[:param]
    @c = Customer.find_by_sql( "select * from customers where id = #{@c_id}")[0]
  end

  def brand_view
    b_id = params[:id]
    arr = []
    @models = []
    @sum = 0
    @o = Order.find_by_sql("Select * from orders where product_id in (select id from products where brand_id = #{b_id})") # com_query
    @b = Brand.find_by_sql("Select * from brands where id = #{b_id}")[0]
    @prod = Order.find_by_sql("Select * from orders, customers")[0]
    unless @o.empty?
      @o.each do |el|
        arr.push([el.product.model, el.amount])
        @models.push([el.product.model,0, el.product.price])
      end
      @models = @models.uniq
      @models.each do |el|
        arr.each do |val|
          if el[0] == val[0]
            el[1] += val[1]
          end
        end
        @sum += el[1] * el[2]
      end
    end
  end

end
