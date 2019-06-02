import psycopg2
import string
from datetime import datetime
import random as rand
import time

# Описание переменных
name = ['Иван','Афанасий','Максим','Исмоил','Николай','Виталий','Виктор','Петр','Алекснадр']
sername = ['Гудзенко','Усошин','Нахимов','Хоботов','Акимов','Иванов','Петров','Сидоров','Павлов','Криволенко','Пустопалов','Нуриддинов',"Комиссаров","Цаплин","Кукли'н"]
street = ['ул. Плющиха, д.','уд. Ленивка, д.','ул. Ильинка, д.','ул. Балчуг, д.','ул. Болотная, д.','ул. Тверская, д.','ул. Фадеева, д.']
ph_num = ['+7977','+7916', '+7967']
e_mat = ['aluminium', 'cast iron']
sym = list(string.ascii_lowercase) + list(map(str,list(range(9))))
rand.shuffle(sym)
exist = ['Да', 'Нет', 'Скоро будет']
drive_unit = ['передний', 'задний', 'полный','подключаемый полный', 'подключаемый задний']
manufact = ['Germany', 'USA', 'Japan', 'France', 'Russia']
logo_a = [["Audi","Germany","logos/audi.png"],["BMW","Germany","logos/bmw.png"], ["Dodge","USA","logos/dodge.png"], ["Ford","USA","logos/ford.png"], #4
   ["Mazda","Japan","logos/mazda.png"],["Mercedes","Germany", "logos/merc.png"],["Nissan","Japan","logos/nissan.png"],["Skoda","Cezh","logos/skoda.png"],["Subaru","Japan","logos/subaru.png"],["Toyota","Japan","logos/toyota.png"]]
bodies = ["седан","хетчбэк","универсал","купе","кроссовер","лифтбек"]
b_mat = ["cast iron", "magnesium alloys", "aluminum alloys", "carbon fiber", "polymer"]
l_engines = ["спереди","сзади"]
fav_product = [["E 200","Да","cars/benz.jpg",4_000_000,1,1,1,6],["AMG GT","Да","cars/benz2.jpg",6_455_000,1,2,2,6],["W205","Да","cars/benz3.jpg",4_229_000,1,3,3,6],
["Octavia","Да","cars/skoda.jpg",1_600_000,1,4,4,8],["Rapid","Да","cars/skoda2.jpg",846_000,1,5,5,8],["i8","Да","cars/bmw4.jpg",8_100_000.9,1,6,6,2],["M3","Да","cars/bmw.jpg",2_650_000,1,7,7,2],
["X5","Да","cars/bmw2.jpg",4_849_000,1,8,8,2],["M2","Да","cars/bmw3.jpg",3_836_000,1,9,9,2],["Impreza WRX STI","Да","cars/subaru.jpg",1_205_000,1,10,10,9]]
rand.shuffle(fav_product)
t_pay = ["наличные","перечисление","пластиковая карта"]
deliver = ["Да","Нет"]
colour = ["зелёный", "жёлтый", "серый", "чёрный", "белый"]
# Functions
def get_name():
   str1 = ''
   for _i in range(rand.randint(3,6)):
      str1 += sym[rand.randint(0, len(sym) - 1)]
   return str1

def bin_num(num):
   str1 = bin(num)
   str1 = str1[2:len(str1)]
   for _i in range(5 - len(str1)):
      str1 = str1[:0] + '0' + str1[0:]
   return str1

def get_price(db, ex_id):
   sum = 0
   arr = db.execute(f"SELECT * FROM extendeds WHERE id = {ex_id}").fetchall()[0]
   sum += arr[1] * 20_000 + arr[2] * 30_000 + arr[3] * 50_000 + arr[4] * 40_000 + arr[5] * 10_000
   return sum

# Execute db
start = time.time()
conn = psycopg2.connect(dbname='myproject_development', user='rails_user',
   password='password_oleg', host='localhost')
db = conn.cursor()
time_s = datetime.strftime(datetime.now(), "%Y-%m-%d %H:%M:%S")
#добавление прав сотрудников(11 наименований) perks
db.execute(f"INSERT INTO perks (del, edit,addn, edit_root, position, created_at, updated_at) VALUES ('1','1','1','1','admin','{time_s}','{time_s}')")
db.execute(f"INSERT INTO perks (del, edit,addn, edit_root, position, created_at, updated_at) VALUES ('1','0','0','0','technicist','{time_s}','{time_s}')")
db.execute(f"INSERT INTO perks (del, edit,addn, edit_root, position, created_at, updated_at) VALUES ('0','1','1','0','designer','{time_s}','{time_s}')")
for i in range(1,9):
   str1 = 'employee' + str(i)
   db.execute(f"INSERT INTO perks (del, edit,addn, edit_root, position, created_at, updated_at) VALUES ('0','0','1','1','{str1}','{time_s}','{time_s}')")
db.execute(f"INSERT INTO perks (del, edit,addn, edit_root, position, created_at, updated_at) VALUES ('0','0','0','0','viewer','{time_s}','{time_s}')")

# добавление администрации users
db.execute(f"INSERT INTO users (email, password_digest, perk_id, created_at, updated_at) VALUES ('oleg@admin', '$2a$10$7/66zipkw1nPpchK0uXIRuDE3efoAusarcGERQiLrqzYqVgrmsC8y',1,'{time_s}','{time_s}')")
db.execute(f"INSERT INTO users (email, password_digest, perk_id, created_at, updated_at) VALUES ('nikita@admin', '$2a$10$Rmk4p6xMS0En9rFaYv4truBKx2bT2UL8CJ89GeINtVi.Xu5.eTqJ2',1,'{time_s}','{time_s}')")
db.execute(f"INSERT INTO users (email, password_digest, perk_id, created_at, updated_at) VALUES ('usopshin@design', '$2a$10$XEQKvhMAVoif27o1dlMj..TWYaO.DlHREqm/rWEnSQpQoAf9Qz13m',2,'{time_s}','{time_s}')")
for i in range (1,9):
   db.execute(f"INSERT INTO users (email, password_digest, perk_id, created_at, updated_at) VALUES ('emp{i}@employee', '$2a$10$pWvIR92CWSMbspGAk0.py.eFfo407VECyAugKIFHUY2r7cmVK6tqO',12,'{time_s}','{time_s}')")

# добавление клиентов(12 человек)
for i in range(12):
   full_name = name[rand.randint(0, len(name)-1)] + ' ' + sername[rand.randint(0, len(sername)-1)]
   streetx = street[rand.randint(0, len(street)-1)] + str(rand.randint(1, 50))
   phone = ph_num[rand.randint(0, len(ph_num)-1)] + str(rand.randint(1_000_000,9_999_999))
   db.execute('INSERT INTO customers (full_name, passport_data, adds, phone_num, created_at, updated_at) VALUES (?,?,?,?,?,?)',
      [full_name,rand.randint(10_000_000,471_000_000),streetx,phone,time_s,time_s])

#добавление двигателей
  #Mercedes-Benz
db.execute(f"INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES ('Mercedes-Benz E 500','бензиновый','aluminum',8,5.5,550,{time_s},{time_s})")
db.execute(f"INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES ('Mercedes-Benz 320 E','бензиновый','aluminum',6,3.2,220,{time_s},{time_s})")
db.execute(f"INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES ('Mercedes-Benz E 300','бензиновый','aluminum',6,2,245,{time_s},{time_s})")
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Mercedes-Benz E 300','бензиновый','aluminum',6,2,245,time_s,time_s])
  #BMW старт с id=4
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['BMW 730i','бензиновый','aluminum',4,2.0,258,time_s,time_s])
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['BMW 740i','бензиновый','aluminum',6,3.0,326,time_s,time_s])
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['BMW 750i','дизельный','aluminum',4,4.4,450,time_s,time_s])
  #Skoda старт с id=7
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Skoda Octavia RS','дизельный','cast iron',6,2.0,230,time_s,time_s])
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Skoda Superb','бензиновый','cast iron',4,2.0,280,time_s,time_s])
  #Subaru старт с id=9
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Subaru Impreza','дизельный','aluminium',4,2.0,150,time_s,time_s])
db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
  ['Subaru WRX STI','бензиновый','aluminium',4,2.5,305,time_s,time_s])
   #noname двигатели(для красоты) старт с id=11
for i in range(50):
  type = ['бензиновый','дизельный','метановый','пропановый']
  db.execute("INSERT INTO typengs (name, kind, material, cyls,val_engine, power, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?)",
   [get_name(),type[rand.randint(0,3)], e_mat[rand.randint(0, len(e_mat)-1)],rand.randint(1,4)*2,rand.randint(2,6),rand.randint(100,600),time_s,time_s])

#добавление таблицы коробок передач(15 шт.)
for _i in range(15):
   gear = ["автоматическая","механическая","полуавтоматическая","вариатор"]
   db.execute("INSERT INTO transmissions (name, gears, diff, created_at, updated_at) VALUES (?,?,?,?,?)",
      [gear[rand.randint(0, len(gear)-1)],rand.randint(4,6),get_name(),time_s,time_s])

#добавление расширенных характеристик автомобиля
  #Mercedes-Benz
db.execute("INSERT INTO extendeds (abs, heating, multim,p_sens, nav, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  [1,1,1,1,1,time_s,time_s])
  #BMW
db.execute("INSERT INTO extendeds (abs, heating, multim,p_sens, nav, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  [1,1,1,1,0,time_s,time_s])
  #over extendeds
for i in range(30):
   estr = bin_num(i)
   db.execute("INSERT INTO extendeds (abs, heating, multim,p_sens, nav, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
      [estr[0],estr[1],estr[2],estr[3],estr[4],time_s,time_s])
# 0 0 0 0 0
db.execute("INSERT INTO extendeds (abs, heating, multim,p_sens, nav, created_at, updated_at) VALUES (?,?,?,?,?,?,?)",
  ['0','0','0','0','0',time_s,time_s])

#добавление приводов !
  #30 записей
for _i in range(30):
   db.execute("INSERT INTO drives (name, weight, manuf, created_at, updated_at) VALUES (?,?,?,?,?)",
      [drive_unit[rand.randint(0,len(drive_unit)-1)],rand.randint(200,650),manufact[rand.randint(0,len(manufact)-1)],time_s,time_s])

#добавление брендов(10 записей)
for el in logo_a:
   db.execute("INSERT INTO brands (name, country, logo, created_at, updated_at) VALUES (?,?,?,?,?)",
      [el[0],el[1],el[2],time_s,time_s])

#добавление кузовов(20 записей)
for _i in range(20):
   db.execute("INSERT INTO bodies (name, material, length, width, created_at, updated_at) VALUES (?,?,?,?,?,?)",
      [bodies[rand.randint(0,len(bodies)-1)],b_mat[rand.randint(0,len(b_mat)-1)],rand.randint(3500,5000),rand.randint(1500,2000),time_s,time_s])

#добавление технических характеристик(30 шт.)
  #Mercedes start id=1
for i in range(1,4):
   db.execute("INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine,mspeed,racing,way_res,drive_id,transmission_id,typeng_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
      [4,5,l_engines[0],rand.randint(220,280),rand.randint(4,8),rand.randint(700,2000),rand.randint(1,30),rand.randint(1,15),i,time_s,time_s])

  #Skoda start id=4
for i in range(7,9):
   db.execute("INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine,mspeed,racing,way_res,drive_id,transmission_id,typeng_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
      [4,5,l_engines[0],rand.randint(180,220),rand.randint(8,12),rand.randint(700,2000),rand.randint(1,30),rand.randint(1,15),i,time_s,time_s])
  #BMW start id=6
for _i in range(4):
   db.execute("INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine,mspeed,racing,way_res,drive_id,transmission_id,typeng_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
      [4,5,l_engines[0],rand.randint(180,220),rand.randint(8,12),rand.randint(700,2000),rand.randint(1,30),rand.randint(1,15),rand.randint(4,6),time_s,time_s])

  #SUBARU start id=10
db.execute("INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine,mspeed,racing,way_res,drive_id,transmission_id,typeng_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
   [4,5,l_engines[0],240,8,1800,rand.randint(1,30),rand.randint(1,15),9,time_s,time_s])

#остальные машины
for _i in range(20):
   db.execute("INSERT INTO teches (num_of_doors, num_of_place, loc_of_engine,mspeed,racing,way_res,drive_id,transmission_id,typeng_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?,?)",
      [rand.randint(2,5),rand.randint(4,6),l_engines[rand.randint(0,len(l_engines)-1)],rand.randint(160,240),rand.randint(4,15),rand.randint(700,2000),rand.randint(1,30),rand.randint(1,15),rand.randint(1,60),time_s,time_s])

#добавление машин(10 шт.)
for el in fav_product:
   db.execute("INSERT INTO products (model,exist,image,price,fav,tech_id,body_id,brand_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)",
      [el[0],el[1],el[2],el[3],str(el[4]),el[5],el[6],el[7],time_s,time_s])

for _i in range(100_000):
   brand = [['audi', 1], ['bmw', 2], ['merc', 6]]
   brand = brand[rand.randint(0,len(brand)-1)]
   if brand[0] == 'audi':
      db.execute("INSERT INTO products (model,exist,image,price,fav,tech_id,body_id,brand_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)",
      [get_name(),exist[rand.randint(0,len(exist)-1)],"other/audi" + str(rand.randint(1,10)) + ".jpg",rand.randint(2_200_000,6_850_000),'0',rand.randint(1,30),rand.randint(1,19),brand[1],time_s,time_s])
   elif brand[0] == 'bmw':
      db.execute("INSERT INTO products (model,exist,image,price,fav,tech_id,body_id,brand_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)",
         [get_name(),exist[rand.randint(0,len(exist)-1)],"other/bmw" + str(rand.randint(1,10)) + ".jpg",rand.randint(2_200_000,6_850_000),'0',rand.randint(1,30),rand.randint(1,19),brand[1],time_s,time_s])
   elif brand[0] == 'merc':
      db.execute("INSERT INTO products (model,exist,image,price,fav,tech_id,body_id,brand_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)",
         [get_name(),exist[rand.randint(0,len(exist)-1)],"other/merc" + str(rand.randint(1,10)) + ".jpg",rand.randint(2_200_000,6_850_000),'0',rand.randint(1,30),rand.randint(1,19),brand[1],time_s,time_s])

#добавление заказов(50 шт.)
for _i in range(50):
   ex_id = rand.randint(1,30)
   car_id = rand.randint(1,10)
   f_price = get_price(db, ex_id) + db.execute(f"SELECT price FROM products WHERE id = {car_id}").fetchall()[0][0]
   db.execute("INSERT INTO orders (amount,type_of_pay,delivery,colour,final_price,extended_id,customer_id,product_id, created_at, updated_at) VALUES (?,?,?,?,?,?,?,?,?,?)",
      [rand.randint(1,3),t_pay[rand.randint(0,len(t_pay)-1)],deliver[rand.randint(0,len(deliver)-1)],colour[rand.randint(0,len(colour)-1)],f_price,ex_id,rand.randint(1,12),car_id,time_s,time_s])

conn.commit()
conn.close()
print("Runtime %s seconds" % (time.time() - start))