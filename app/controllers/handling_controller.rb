# контроллер для POST - запросов
class HandlingController < ApplicationController

    def add_customers
        u = Perk.find_by_sql("SELECT del,edit,addn,edit_root FROM perks WHERE id IN (SELECT perk_id FROM users WHERE id = #{session[:user_id]})")[0]
        if u.addn # com_query
          sql = "INSERT INTO customers (full_name, passport_data, adds, phone_num, created_at, updated_at)
           VALUES ('#{params[:full]}', '#{params[:pass]}', '#{params[:ads]}', '#{params[:num]}', '#{Time.now.to_s}', '#{Time.now.to_s}')"
          ActiveRecord::Base.connection.execute(sql)
        end
      end

      def del_customer
        u = Perk.find_by_sql("SELECT del,edit,addn,edit_root FROM perks WHERE id IN (SELECT perk_id FROM users WHERE id = #{session[:user_id]})")[0]
        if u.del # com_query
          sql = "DELETE FROM customers WHERE id = #{params[:c_id]}"
          ActiveRecord::Base.connection.execute(sql)
        end
      end
    # Редактирование данных клиента
      def edit
        u = Perk.find_by_sql("SELECT del,edit,addn,edit_root FROM perks WHERE id IN (SELECT perk_id FROM users WHERE id = #{session[:user_id]})")[0]
        if u.edit # com_query
          sql = "UPDATE customers SET full_name = '#{params[:full]}', passport_data = '#{params[:pass]}',
            adds = '#{params[:ads]}', phone_num = '#{params[:num]}' WHERE id = #{params[:c_id]}"
          ActiveRecord::Base.connection.execute(sql)
        end
      end
    
      def add_car
        u = Perk.find_by_sql("SELECT del,edit,addn,edit_root FROM perks WHERE id IN (SELECT perk_id FROM users WHERE id = #{session[:user_id]})")[0]
        if u.addn # com_query
          unless Brand.row_exist?(params[:brand])
            Brand.add_row(params[:brand],params[:country])
          end
          Drive.add_row(params[:drive])
          Body.add_row(params[:body])
          Typeng.add_row(params[:n_eng],params[:t_eng],params[:v_eng],params[:power])
          Tech.add_row(params[:doors],params[:places],params[:l_eng],params[:mspeed])
          Product.add_row(params[:model],params[:exist],params[:image],params[:price],params[:brand])
        end
      end  
    
      def del_car
        u = Perk.find_by_sql("SELECT del,edit,addn,edit_root FROM perks WHERE id IN (SELECT perk_id FROM users WHERE id = #{session[:user_id]})")[0]
        if u.del # com_query
          sql = "DELETE from products where id = #{params[:c_id]}"
          ActiveRecord::Base.connection.execute(sql)
        end
      end
    
      def edit_car
        u = Perk.find_by_sql("SELECT del,edit,addn,edit_root FROM perks WHERE id IN (SELECT perk_id FROM users WHERE id = #{session[:user_id]})")[0]
        if u.edit # com_query
          p_id = params[:c_id]
          oth_id = Product.find_by_sql("SELECT brand_id,tech_id,body_id FROM products WHERE id = #{p_id}")[0]
          an_id = Tech.find_by_sql("SELECT drive_id, typeng_id FROM teches WHERE id = #{oth_id.tech_id}")[0]
          Brand.update_row(oth_id.brand_id,params[:brand],params[:country])
          Drive.update_row(an_id.drive_id,params[:drive])
          Body.update_row(oth_id.body_id,params[:body])
          Typeng.update_row(an_id.typeng_id,params[:n_eng],params[:t_eng],params[:v_eng],params[:power])
          Tech.update_row(oth_id.tech_id,params[:doors],params[:places],params[:l_eng],params[:mspeed])
          Product.update_row(p_id,params[:model],params[:exist],params[:image],params[:price])
        end
      end

      def del_order
        u = Perk.find_by_sql("SELECT del,edit,addn,edit_root FROM perks WHERE id IN (SELECT perk_id FROM users WHERE id = #{session[:user_id]})")[0]
        if u.del # com_query
            sql = "DELETE from orders where id = #{params[:order_id]}"
            ActiveRecord::Base.connection.execute(sql)
        end
      end

      def edit_order
        u = Perk.find_by_sql("SELECT del,edit,addn,edit_root FROM perks WHERE id IN (SELECT perk_id FROM users WHERE id = #{session[:user_id]})")[0]
        if u.edit_root # com_query
          Order.update_row(params[:o_id],params[:amount],params[:t_pay],params[:delivery],params[:colour],
            Extended.get_row_id(params[:abs],params[:heating],params[:multim],params[:p_sens],params[:nav]))
        end
      end

      def add_order
        u = Perk.find_by_sql("SELECT del,edit,addn,edit_root FROM perks WHERE id IN (SELECT perk_id FROM users WHERE id = #{session[:user_id]})")[0]
        if u.addn # com_query
          Order.add_row(params[:p_id],params[:c_id],params[:t_pay],params[:delivery],params[:colour],
            Extended.get_row_id(params[:abs],params[:heating],params[:multim],params[:p_sens],params[:nav]),params[:amount])
        end
      end
end
