class Typeng < ApplicationRecord
    has_many :tech

    def self.row_exist?(name)
      t = Typeng.find_by_sql("SELECT id FROM typengs WHERE name = '#{name}' LIMIT 1")
      !t.empty?
    end

    def self.add_row(name,kind,val,power)
      sql = "INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at)
       VALUES ('#{name}','#{kind}','cast iron',#{(rand(2)+2)*2},#{val},#{power},'#{Time.now.to_s}','#{Time.now.to_s}')"
       ActiveRecord::Base.connection.execute(sql)
    end

    def self.update_row(id,name,kind,val,power)
      sql = "UPDATE typengs SET name = '#{name}', kind = '#{kind}', val_engine = #{val}, power = #{power} WHERE id = #{id}"
      ActiveRecord::Base.connection.execute(sql)
    end
end
