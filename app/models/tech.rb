class Tech < ApplicationRecord
  has_many :product
  belongs_to :drive
  belongs_to :transmission
  belongs_to :typeng

  def self.add_row(door, place, loce, mspeed)
    sql = "INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine, mspeed, racing, way_res, drive_id, transmission_id, typeng_id, created_at, updated_at)
      VALUES(#{door},#{place},'#{loce}','#{mspeed}','#{rand(6..10)}','#{rand(1000..2000)}',(SELECT id FROM drives ORDER BY id DESC LIMIT 1),#{rand(15)+1},(SELECT id FROM typengs ORDER BY id DESC LIMIT 1),'#{Time.now.to_s}','#{Time.now.to_s}')"
    ActiveRecord::Base.connection.execute(sql) # com_query
  end
  
  def self.update_row(id, door, place, loce, mspeed)
    sql = "UPDATE teches SET num_of_doors = #{door}, num_of_place = #{place}, loc_of_engine = '#{loce}', mspeed = '#{mspeed}' WHERE id = #{id}"
    ActiveRecord::Base.connection.execute(sql)
  end
end
