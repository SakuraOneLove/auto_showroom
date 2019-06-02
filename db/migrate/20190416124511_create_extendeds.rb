class CreateExtendeds < ActiveRecord::Migration[5.2]
  def change
    create_table :extendeds do |t|
      t.boolean :abs
      t.boolean :heating  #подогрев
      t.boolean :multim #мультимедиа
      t.boolean :p_sens #парктроник
      t.boolean :nav  #навигатор

      t.timestamps
    end
  end
end
