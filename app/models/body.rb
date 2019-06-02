class Body < ApplicationRecord
    has_many :product

    def self.row_exist?(name)
      b = Body.find_by_sql("SELECT id FROM bodies WHERE name = '#{name}' LIMIT 1")
      !b.empty?
    end

    def self.add_row(name)
      sql = "INSERT INTO bodies (name, material, length, width, created_at, updated_at)
       VALUES ('#{name}','aluminum alloys',#{rand(3500..5000)},#{rand(1500..2000)},'#{Time.now.to_s}','#{Time.now.to_s}')"
      ActiveRecord::Base.connection.execute(sql)
    end

    def self.update_row(id, name)
      sql = "UPDATE bodies SET name = '#{name}' WHERE id = #{id}"
      ActiveRecord::Base.connection.execute(sql)
    end
end
