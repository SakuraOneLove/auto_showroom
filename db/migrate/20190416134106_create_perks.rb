# таблица с правами менеджеров
class CreatePerks < ActiveRecord::Migration[5.2]
  def change
    create_table :perks do |t|
      t.boolean :del
      t.boolean :edit #редактирование всего остального
      t.boolean :addn #добавление новых авто, клиентов, заказов
      t.boolean :edit_root  #редактирование заказов
      t.string :position  #должность менеджера

      t.timestamps
    end
  end
end
