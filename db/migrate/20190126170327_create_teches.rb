class CreateTeches < ActiveRecord::Migration[5.2]
  def change
    create_table :teches do |t|
      t.integer :num_of_doors
      t.integer :num_of_place
      t.string :loc_of_engine #расположение двигателя
      t.string :mspeed  #максимальная скорость
      t.string :racing  #время разгона до 100км/ч
      t.string :way_res #запас хода
      t.integer :drive_id
      t.integer :transmission_id
      t.integer :typeng_id
      t.timestamps
    end
  end
end
