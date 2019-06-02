class Brand < ApplicationRecord
    has_many :product

    def self.add_row(name,country)
      if File.exist?("app/assets/images/logos/#{name.downcase}" + ".png")
        sql = "INSERT INTO brands (name, country, logo, created_at, updated_at) VALUES('#{name}','#{country}','logos/#{name.downcase}.png','#{Time.now.to_s}','#{Time.now.to_s}')"
      else
        sql = "INSERT INTO brands (name, country, logo, created_at, updated_at) VALUES('#{name}','#{country}','nologo','#{Time.now.to_s}','#{Time.now.to_s}')"
      end
        ActiveRecord::Base.connection.execute(sql)
    end

    def self.row_exist?(name)
      b = Brand.find_by_sql("SELECT id FROM brands WHERE name = '#{name}' LIMIT 1")
      !b.empty?
    end  

    def self.update_row(id, name, country)
      sql = "UPDATE brands SET name = '#{name}', country = '#{country}' WHERE id = #{id}"
      ActiveRecord::Base.connection.execute(sql)
    end
end
