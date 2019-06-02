class CreateTransmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :transmissions do |t|
      t.string :name
      t.string :gears
      t.string :diff

      t.timestamps
    end
  end
end
