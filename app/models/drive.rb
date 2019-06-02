class Drive < ApplicationRecord
    has_many :tech

    def self.row_exist?(name)
      d = Drive.find_by_sql("SELECT id FROM drives WHERE name = '#{name}' LIMIT 1")
      !d.empty?
    end

    def self.add_row(name)
      sql = "INSERT INTO drives (name, weight, manuf, created_at, updated_at)
        VALUES ('#{name}', #{rand(200..650)}, 'Германия','#{Time.now.to_s}','#{Time.now.to_s}')"
      ActiveRecord::Base.connection.execute(sql)
    end
    
    def self.update_row(id, name)
      sql = "UPDATE drives SET name = '#{name}' WHERE id = #{id}"
      ActiveRecord::Base.connection.execute(sql)
    end
end
