require 'sqlite3'
require 'bcrypt'

name = ['Иван','Афанасий','Максим','Исмоил','Николай','Виталий','Виктор','Петр','Алекснадр']
sername = ['Гудзенко','Усошин','Нахимов','Хоботов','Акимов','Иванов','Петров','Сидоров','Павлов','Криволенко','Пустопалов','Нуриддинов',"Комиссаров","Цаплин","Кукли'н"]
street = ['ул. Плющиха, д.','уд. Ленивка, д.','ул. Ильинка, д.','ул. Балчуг, д.','ул. Болотная, д.','ул. Тверская, д.','ул. Фадеева, д.']
ph_num = ['+7977','+7916', '+7967']
e_mat = ['aluminium', 'cast iron']
SYM = (('a'..'z').to_a + ('1'..'9').to_a).shuffle #константа, иначе не видна в функции
EXIST = ['Да', 'Нет', 'Скоро будет']
drive_unit = ['передний', 'задний', 'полный','подключаемый полный', 'подключаемый задний']
manufact = ['Germany', 'USA', 'Japan', 'France', 'Russia']
logo_a = [["Audi","Germany","logos/audi.png"],["BMW","Germany","logos/bmw.png"], ["Dodge","USA","logos/dodge.png"], ["Ford","USA","logos/ford.png"], #4
   ["Mazda","Japan","logos/mazda.png"],["Mercedes","Germany", "logos/merc.png"],["Nissan","Japan","logos/nissan.png"],["Skoda","Cezh","logos/skoda.png"],["Subaru","Japan","logos/subaru.png"],["Toyota","Japan","logos/toyota.png"]]
bodies = ["седан","хетчбэк","универсал","купе","кроссовер","лифтбек"]
b_mat = ["cast iron", "magnesium alloys", "aluminum alloys", "carbon fiber", "polymer"]
l_engines = ["спереди","сзади"]
fav_product = [["E 200","Да","cars/benz.jpg",4_000_000,1,1,1,6],["AMG GT","Да","cars/benz2.jpg",6_455_000,1,2,2,6],["W205","Да","cars/benz3.jpg",4_229_000,1,3,3,6],
["Octavia","Да","cars/skoda.jpg",1_600_000,1,4,4,8],["Rapid","Да","cars/skoda2.jpg",846_000,1,5,5,8],["i8","Да","cars/bmw4.jpg",8_100_000.9,1,6,6,2],["M3","Да","cars/bmw.jpg",2_650_000,1,7,7,2],
["X5","Да","cars/bmw2.jpg",4_849_000,1,8,8,2],["M2","Да","cars/bmw3.jpg",3_836_000,1,9,9,2],["Impreza WRX STI","Да","cars/subaru.jpg",1_205_000,1,10,10,9]].shuffle
t_pay = ["наличные","перечисление","пластиковая карта"]
deliver = ["Да","Нет"]
colour = ["зелёный", "жёлтый", "серый", "чёрный", "белый"]

# случайное название
def get_name
  str = ''
  rand(3..6).times { str += SYM.sample }
  str
end

# формирование extended параметров
def bin_num(num)
  str = num.to_s(2)
  (5 - str.size).times { str.insert(0,'0') }
  str
end

def get_price(db, ex_id)
  sum = 0
  arr = db.execute("SELECT * FROM extendeds WHERE id = #{ex_id}")[0]
  sum += arr[1] * 20_000 + arr[2] * 30_000 + arr[3] * 50_000 + arr[4] * 40_000 + arr[5] * 10_000
  sum
end

start = Time.now

db = SQLite3::Database.new "development.sqlite3"
#добавление прав сотрудников(11 наименований) perks
db.execute("INSERT INTO perks (del, edit,addn, edit_root, position, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  [1,1,1,1,'admin',Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO perks (del, edit,addn, edit_root, position, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  [1,0,0,0,'technicist',Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO perks (del, edit,addn, edit_root, position, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  [0,1,1,0,'designer',Time.now.to_s,Time.now.to_s])
1.upto(8) do |i|
  db.execute("INSERT INTO perks (del, edit,addn, edit_root, position, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  [0,0,1,1,'employee'+i.to_s,Time.now.to_s,Time.now.to_s])
end
db.execute("INSERT INTO perks (del, edit,addn, edit_root, position, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  [0,0,0,0,'viewer',Time.now.to_s,Time.now.to_s])

#добавление администрации(4 человека) users
db.execute("INSERT INTO users (email, password_digest, perk_id, created_at, updated_at) VALUES (?,?,?,?,?)",
  ['oleg@admin', BCrypt::Password.create('1234'),1,Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO users (email, password_digest, perk_id, created_at, updated_at) VALUES (?,?,?,?,?)",
  ['nikita@admin', BCrypt::Password.create('4321'),1,Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO users (email, password_digest, perk_id, created_at, updated_at) VALUES (?,?,?,?,?)",
  ['vova_k@tech', BCrypt::Password.create('123'),1,Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO users (email, password_digest, perk_id, created_at, updated_at) VALUES (?,?,?,?,?)",
  ['usopshin@design', BCrypt::Password.create('123'),2,Time.now.to_s,Time.now.to_s])
#менеджеры
db.execute("INSERT INTO users (email, password_digest, perk_id, created_at, updated_at) VALUES (?,?,?,?,?)",
  ['emp@employee', BCrypt::Password.create('1029'),12,Time.now.to_s,Time.now.to_s])

#добавление клиентов(12 человек)
12.times do
  db.execute("INSERT INTO customers (full_name, passport_data, adds, phone_num, created_at, updated_at) VALUES (?,?,?,?,?,?)",
  [name.sample + ' ' + sername.sample, rand(410_000_000..471_000_000), street.sample + rand(1..50).to_s,ph_num.sample + rand(1_000_000..9_999_999).to_s,Time.now.to_s,Time.now.to_s])
end

#добавление двигателей
  #Mercedes-Benz
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Mercedes-Benz E 500','бензиновый','aluminum',8,5.5,550,Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Mercedes-Benz 320 E','бензиновый','aluminum',6,3.2,220,Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Mercedes-Benz E 300','бензиновый','aluminum',6,2,245,Time.now.to_s,Time.now.to_s])
  #BMW старт с id=4
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['BMW 730i','бензиновый','aluminum',4,2.0,258,Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['BMW 740i','бензиновый','aluminum',6,3.0,326,Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['BMW 750i','дизельный','aluminum',4,4.4,450,Time.now.to_s,Time.now.to_s])
  #Skoda старт с id=7
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Skoda Octavia RS','дизельный','cast iron',6,2.0,230,Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Skoda Superb','бензиновый','cast iron',4,2.0,280,Time.now.to_s,Time.now.to_s])
  #Subaru старт с id=9
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Subaru Impreza','дизельный','aluminium',4,2.0,150,Time.now.to_s,Time.now.to_s])
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Subaru WRX STI','бензиновый','aluminium',4,2.5,305,Time.now.to_s,Time.now.to_s])
  #noname двигатели(для красоты) старт с id=11
50.times do |i|
  type = ['бензиновый','дизельный','метановый','пропановый']
  db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  [get_name,type.sample, e_mat.sample,rand(1..4)*2,rand(2..6),rand(100..600),Time.now.to_s,Time.now.to_s])
end

#добавление таблицы коробок передач(15 шт.)
15.times do 
gear = ["автоматическая","механическая","полуавтоматическая","вариатор"]
  db.execute("INSERT INTO transmissions (name, gears, diff, created_at, updated_at) VALUES (?,?,?,?,?)",
    [gear.sample,rand(4..6).to_s,get_name,Time.now.to_s,Time.now.to_s])
end

#добавление расширенных характеристик автомобиля
  #Mercedes-Benz
db.execute("INSERT INTO extendeds (abs, heating, multim,p_sens, nav, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  [1,1,1,1,1,Time.now.to_s,Time.now.to_s])
  #BMW
db.execute("INSERT INTO extendeds (abs, heating, multim,p_sens, nav, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  [1,1,1,1,0,Time.now.to_s,Time.now.to_s])
  #over extendeds
29.downto(1) do |i|
  estr = bin_num(i)
  db.execute("INSERT INTO extendeds (abs, heating, multim,p_sens, nav, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
    [estr[0].to_i,estr[1].to_i,estr[2].to_i,estr[3].to_i,estr[4].to_i,Time.now.to_s,Time.now.to_s])
end
# 0 0 0 0 0
db.execute("INSERT INTO extendeds (abs, heating, multim,p_sens, nav, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  [0,0,0,0,0,Time.now.to_s,Time.now.to_s])

#добавление приводов
  #30 записей
30.times do
  db.execute("INSERT INTO drives (name, weight, manuf, created_at, updated_at) VALUES (?,?,?,?,?)",
    [drive_unit.sample,rand(200..650),manufact.sample,Time.now.to_s,Time.now.to_s])
end

#добавление брендов(10 записей)
logo_a.each do |el|
  db.execute("INSERT INTO brands (name, country, logo, created_at, updated_at) VALUES (?,?,?,?,?)",
    [el[0],el[1],el[2],Time.now.to_s,Time.now.to_s])
end

#добавление кузовов(20 записей)
50.times do 
  db.execute("INSERT INTO bodies (name, material, length, width, created_at, updated_at) VALUES (?,?,?,?,?,?)",
    [bodies.sample,b_mat.sample,rand(3500..5000),rand(1500..2000),Time.now.to_s,Time.now.to_s])
end

#добавление технических характеристик(30 шт.)
  #Mercedes start id=1
1.upto(3) do |i|
  db.execute("INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine,mspeed,racing,
    way_res,drive_id,transmission_id,typeng_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
      [4,5,l_engines[0],rand(220..280),rand(4..8),rand(700..2000),rand(1..30),rand(1..15),i,Time.now.to_s,Time.now.to_s])
end
  #Skoda start id=4
7.upto(8) do |i|
  db.execute("INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine,mspeed,racing,
    way_res,drive_id,transmission_id,typeng_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
      [4,5,l_engines[0],rand(180..220),rand(8..12),rand(700..2000),rand(1..30),rand(1..15),i,Time.now.to_s,Time.now.to_s])
end
  #BMW start id=6
4.times do
  db.execute("INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine,mspeed,racing,
    way_res,drive_id,transmission_id,typeng_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
      [4,5,l_engines[0],rand(180..220),rand(8..12),rand(700..2000),rand(1..30),rand(1..15),rand(4..6),Time.now.to_s,Time.now.to_s])
end
  #SUBARU start id=10
  db.execute("INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine,mspeed,racing,
    way_res,drive_id,transmission_id,typeng_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
      [4,5,l_engines[0],240,8,1800,rand(1..30),rand(1..15),9,Time.now.to_s,Time.now.to_s])
  #остальные машины
20.times do 
  db.execute("INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine,mspeed,racing,
    way_res,drive_id,transmission_id,typeng_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
      [rand(2..5),rand(4..6),l_engines.sample,rand(160..240),rand(4..15),rand(700..2000),rand(1..30),rand(1..15),rand(1..60),Time.now.to_s,Time.now.to_s])
end

#добавление машин(10 шт.)
fav_product.each do |el|
  db.execute("INSERT INTO products (model,exist,image,price,fav,tech_id,body_id,brand_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)",
    [el[0],el[1],el[2],el[3],el[4],el[5],el[6],el[7],Time.now.to_s,Time.now.to_s])
end

50.times do
  brand = [['audi', 1], ['bmw', 2], ['merc', 6]].sample
  if brand[0] == 'audi'
    db.execute("INSERT INTO products (model,exist,image,price,fav,tech_id,body_id,brand_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)",
    [get_name,EXIST.sample,"other/audi#{rand(10)+1}.jpg",rand(2_200_000..6_850_000),0,rand(30)+1,rand(50)+1,brand[1],Time.now.to_s,Time.now.to_s])
  elsif brand[0] == 'bmw'
    db.execute("INSERT INTO products (model,exist,image,price,fav,tech_id,body_id,brand_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)",
    [get_name,EXIST.sample,"other/bmw#{rand(10)+1}.jpg",rand(2_200_000..6_850_000),0,rand(30)+1,rand(50)+1,brand[1],Time.now.to_s,Time.now.to_s])
  elsif brand[0] == 'merc'
    db.execute("INSERT INTO products (model,exist,image,price,fav,tech_id,body_id,brand_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)",
    [get_name,EXIST.sample,"other/merc#{rand(10)+1}.jpg",rand(2_200_000..6_850_000),0,rand(30)+1,rand(50)+1,brand[1],Time.now.to_s,Time.now.to_s])
  end
end

#добавление заказов(50 шт.)
50.times do
  ex_id = rand(30) + 1
  car_id = rand(10) + 1
  f_price = get_price(db, ex_id) + db.execute("SELECT price FROM products WHERE id = #{car_id}")[0][0]
  db.execute("INSERT INTO orders (amount,type_of_pay,delivery,colour,final_price,extended_id,customer_id,product_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)",
    [rand(3)+1,t_pay.sample,deliver.sample,colour.sample,f_price,ex_id,rand(12) + 1,car_id,Time.now.to_s,Time.now.to_s])
end

puts "Runtime #{Time.now - start}c"