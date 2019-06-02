class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :full_name
      t.string :passport_data
      t.string :adds
      t.string :phone_num

      t.timestamps
    end
  end
end
