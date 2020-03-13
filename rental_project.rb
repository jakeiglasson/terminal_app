require "csv"
require "colorize"
require "artii"
require "terminal-table"
require "tty-box"

#-----methods
def modify_entry

  new_hash = nil
  old_hash = nil

  table = CSV.parse(File.read("equipment_db.csv"), headers: true)
  x = table.length
  y = 0
  temp_db = []
  while x > 0
    temp_db.push({ #HiredBy,HireDate,
      :EquipmentName => table[0+y][0],
      :DailyHirePrice => table[0+y][1],
      :Status => table[0+y][2],
      :HiredBy => table[0+y][3],
      :HireDate => table[0+y][4],
      :DueBackDate => table[0+y][5],
      :ID => table[0+y][6]
      })
    y += 1
    x = x - 1
  end

  puts "Enter the ID to modify (type exit to cancel and go back to menu): "
  print "=> "
  user_input = gets.chomp

  if user_input.downcase == "exit"
    return
  end
  
  temp_db.each do |items| #finds id and assigns hash to x
    items.each{|key, value| 
      if key == :ID
        if value == user_input
         new_hash = items
        end
      end
    }
  end

  temp_db.each do |itemsb| #finds id and assigns hash to x
    itemsb.each{|key, value| 
      if key == :ID
        if value == user_input
         old_hash = itemsb.clone
        end
      end
    }
  end

  puts "Status of the equipment: hired/available"
  print "=> "
  new_hash[:Status] = gets.chomp

  puts "Name of person who hired the equipment"
  print "=> "
  new_hash[:HiredBy] = gets.chomp

  puts "Date equipment was hired: dd/mm/yyyy"
  print "=> "
  new_hash[:HireDate] = gets.chomp

  puts "Due back date of the quipment: dd/mm/yyyy"
  print "=> "
  new_hash[:DueBackDate] = gets.chomp

  #get current db, remove unmdofied entry, place modified entry
  table = CSV.parse(File.read("equipment_db.csv"), headers: true)
    x = table.length
    y = 0
    temp_db = []
  while x > 0
    temp_db.push({ #HiredBy,HireDate,
      :EquipmentName => table[0+y][0],
      :DailyHirePrice => table[0+y][1],
      :Status => table[0+y][2],
      :HiredBy => table[0+y][3],
      :HireDate => table[0+y][4],
      :DueBackDate => table[0+y][5],
      :ID => table[0+y][6]
      })
    y += 1
    x = x - 1
  end

  temp_db.each do |items| #finds id and assigns hash to x
    items.each{|key, value| 
      if key == :ID
        if value == user_input
         x = items
        end
      end
    }
  end

  temp_db = temp_db.map do |e|
    if e == old_hash
      new_hash
    else
      e
    end
  end

  $equipment_db = temp_db
  write_equipment_to_db(false, true)

end

def create_customer

  #Get user input for customer name and address
  puts "Name of customer:"
  print "=> "
  customer_name = gets.chomp
  puts "address of customer:"
  print "=> "
  customer_address = gets.chomp

  new_customer = Customer.new(customer_name,customer_address)
  $cus_db.push(new_customer.read) #Add customer to temp db
  $full_cus_db.push(new_customer.read) #Add customer to full db for displaying

  # while true
  #   puts "Create another customer? y/n"
  #   print "=> "
  #   user_input = (gets.chomp).downcase
  #   if (user_input == "n") || (user_input == "y")
  #     break
  #   else
  #     puts "invalid input"
  #   end
  # end

  # if user_input == "n"
  #   break
  # end

end

def create_equipment

  #Get user input for equipment name and price
  puts "Name of equipment:"
  print "=> "
  equipment_name = gets.chomp
  puts "Daily price of equipment:"
  print "=> "
  equipment_price = gets.chomp

  new_equipment = Equipment.new(equipment_name,equipment_price)
  $equipment_db.push(new_equipment.read) #Add equipment to temp db
  $full_eqp_db.push(new_equipment.read) #Add equipment to full db for displaying

  # while true
  #   puts "Create another equipment entry? y/n"
  #   print "=> "
  #   user_input = (gets.chomp).downcase
  #   if (user_input == "n") || (user_input == "y")
  #     break
  #   else
  #     puts "invalid input"
  #   end
  # end

  # if user_input == "n"

  #   break
  # end

end

def write_customer_to_db(append, overwrite)

  if append == true
    $cus_db.each do |items|
      x = items.length
      items.each{|key, value|
        File.open("customer_db.csv", "a") do |line|
          line << value
          line << ","
          x = x-1
          if x == 0
            line << "\n"
          end
        end  
      }

    end

    p "customer db file appended"
  end

  if overwrite == true

    #delete current file
    File.delete("customer_db.csv") if File.exist?("customer_db.csv")

    #create file
    File.open("customer_db.csv", "w") do |line|
      line << "Name,Address,ID\n"
    p "creating customer db file"
    end

    $cus_db.each do |items|
      x = items.length
      items.each{|key, value|
        File.open("customer_db.csv", "a") do |line|
          line << value
          line << ","
          x = x-1
          if x == 0
            line << "\n"
          end
        end  
      }

    end

    p "customer db file overwritten" 
  end
  

end

def write_equipment_to_db(append, overwrite)

  if append == true
    $equipment_db.each do |items|
      x = items.length
      items.each{|key, value|
        File.open("equipment_db.csv", "a") do |line|
          line << value
          line << ","
          x = x-1
          if x == 0
            line << "\n"
          end
        end  
      }

    end

    p "equipment appended to db"
  end

  if overwrite == true

    #delete current file
    File.delete("equipment_db.csv") if File.exist?("equipment_db.csv")

    #create file
    File.open("equipment_db.csv", "w") do |line|
      line << "EquipmentName,DailyHirePrice,Status,HiredBy,HireDate,DueBackDate,ID\n"
    p "creating equipment db file"
    end

    $equipment_db.each do |items|
      x = items.length
      items.each{|key, value|
        File.open("equipment_db.csv", "a") do |line|
          line << value
          line << ","
          x = x-1
          if x == 0
            line << "\n"
          end
        end  
      }

    end

    p "equipment eppended to db"
  end

end

def display_db_info(db)

  puts "Displaying database info:"
  puts "\n"
  #Display data from database
  db.each do |items|
    items.each{|key, value| puts "#{key}: #{value}"}
    puts "\n"
  end
  puts "\n"

end

def remove_entry(db_file)

  # p $full_cus_db

  if db_file == "customer_db"
    table = CSV.parse(File.read("customer_db.csv"), headers: true)
    x = table.length
    y = 0
    temp_db = []
    while x > 0
      temp_db.push({
        :Name => table[0+y][0],
        :Address => table[0+y][1],
        :ID => table[0+y][2]
        })
      y += 1
      x = x - 1
    end
  end

  if db_file == "equipment_db" 
    table = CSV.parse(File.read("equipment_db.csv"), headers: true)
    x = table.length
    y = 0
    temp_db = []
    while x > 0
      temp_db.push({ #HiredBy,HireDate,
        :EquipmentName => table[0+y][0],
        :DailyHirePrice => table[0+y][1],
        :Status => table[0+y][2],
        :HiredBy => table[0+y][3],
        :HireDate => table[0+y][4],
        :DueBackDate => table[0+y][5],
        :ID => table[0+y][6]
        })
      y += 1
      x = x - 1
    end
  end

  puts "Enter the ID to remove (type exit to cancel and go back to menu): "
  print "=> "
  user_input = gets.chomp

  if user_input.downcase == "exit"
    return
  end
  
  temp_db.each do |items| #finds id and assigns hash to x
    items.each{|key, value| 
      if key == :ID
        if value == user_input
         x = items
        end
      end
    }
  end

  temp_db.delete(x) #delete hash from temp database

  # pp temp_cus_db

  if db_file == "customer_db"
    $cus_db = temp_db
    write_customer_to_db(false, true)
  end
  if db_file == "equipment_db"
    $equipment_db = temp_db
    write_equipment_to_db(false, true)
  end

  puts "in remove entry"
  p $equipment_db

  

end

def get_full_cus_db
  $full_cus_db = []
  p "getting existing customer info"
  table = CSV.parse(File.read("customer_db.csv"), headers: true)

  x = table.length
  y = 0
  # cus_db = []

  while x > 0
    $full_cus_db.push({
      :Name => table[0+y][0],
      :Address => table[0+y][1],
      :ID => table[0+y][2]
      })
    y += 1
    x = x - 1
  end
end

def get_full_eqp_db
  $full_eqp_db = []
  p "getting existing equipment info"
  table = CSV.parse(File.read("equipment_db.csv"), headers: true)

  x = table.length
  y = 0
  # equipment_db = []

  while x > 0
    $full_eqp_db.push({
      :EquipmentName => table[0+y][0],
      :DailyHirePrice => table[0+y][1],
      :Status => table[0+y][2], 
      :HiredBy => table[0+y][3],
      :HireDate => table[0+y][4],
      :DueBackDate => table[0+y][5],
      :ID => table[0+y][6]
      })
    y += 1
    x = x - 1
  end
end

def menu

  while true
    
    box = TTY::Box.frame "Equipment Hire", padding: 3, align: :center
    print box

    puts "\n"
    a = Artii::Base.new :font => 'alphabet'
    puts (a.asciify('WELCOME')).colorize(:blue)


    puts "----- MENU SELECTION -----"
    puts "Type the corresponding number for selection:"
    puts "1. Create Customer"
    puts "2. Create Equipment"
    puts "3. List Customers"
    puts "4. List Equipment"
    puts "5. remove customer entry from database"
    puts "6. remove equipment entry from database"
    puts "7. Modify equipment status"
    puts "Type exit to quit"
    print "=> "

    $menu_input = gets.chomp

    if $menu_input.downcase != "exit"
      $menu_input = $menu_input.to_i
    end

    if ($menu_input.is_a? Integer) && ($menu_input != 0 && $menu_input < 8)
      break
    elsif ($menu_input.is_a? String) && ($menu_input.downcase == "exit" )
      break
    else
      puts "Invalid input, try again"
    end

  end

  if $menu_input == 1
    $cus_db = []
    create_customer
    write_customer_to_db(true,false)
  end

  if $menu_input == 2
    $equipment_db = []
    create_equipment
    write_equipment_to_db(true,false)
  end

  if $menu_input == 3
    puts "Selection: List Customers\n"
    get_full_cus_db
    display_db_info($full_cus_db)
  end

  if $menu_input == 4
    puts "Equipment list: \n"
    get_full_eqp_db
    display_db_info($full_eqp_db)
  end

  if $menu_input == 5
    display_db_info($full_cus_db)
    remove_entry("customer_db")
  end

  if $menu_input == 6
    display_db_info($full_eqp_db)
    remove_entry("equipment_db")
  end

  if $menu_input == 7
    modify_entry
  end

end

#-----global variables
$menu_input = 0



#-----databases
#initialize temp database for ADDING new customers and equipment to file
$cus_db = []
$equipment_db = []

#initialize databases for all info from file AND created in program
$full_cus_db = []
$full_eqp_db = []

#Id databse
# $cus_id_db = [0]
# $equipment_id_db = [0]

cus_db_skip = true
eqp_db_skip = true




#check if customer db (csv file) exists, if not initialize it
if FileTest.exist?("customer_db.csv") == false
  File.open("customer_db.csv", "w") do |line|
    line << "Name,Address,ID\n"
    p "creating customer db file"
  end
else
  cus_db_skip = false
end

#check if equipment db (csv file) exists, if not initialize it
if FileTest.exist?("equipment_db.csv") == false
  File.open("equipment_db.csv", "w") do |line|
    line << "EquipmentName,DailyHirePrice,Status,DueBackDate,ID\n"
    p "creating equipment db file"
  end
else
  eqp_db_skip = false
end




#parse customer DB file into array of hashes if it existed before running program
if cus_db_skip == false
  get_full_cus_db
  # p "getting existing customer info"
  # table = CSV.parse(File.read("customer_db.csv"), headers: true)

  # x = table.length
  # y = 0
  # # cus_db = []

  # while x > 0
  #   $full_cus_db.push({
  #     :Name => table[0+y][0],
  #     :Address => table[0+y][1],
  #     :ID => table[0+y][2]
  #     })
  #   y += 1
  #   x = x - 1
  # end
end

#parse equipment DB file into array of hashes if it existed before running program
if eqp_db_skip == false
  get_full_eqp_db
  # p "getting existing equipment info"
  # table = CSV.parse(File.read("equipment_db.csv"), headers: true)

  # x = table.length
  # y = 0
  # # equipment_db = []

  # while x > 0
  #   $full_eqp_db.push({
  #     :EquipmentName => table[0+y][0],
  #     :DailyHirePrice => table[0+y][1],
  #     :Status => table[0+y][2],
  #     :DueBackDate => table[0+y][3],
  #     :ID => table[0+y][4]
  #     })
  #   y += 1
  #   x = x - 1
  # end
end



#-----classes
class Customer
  # if $cus_id_db.length > 0
  #   @id = $cus_id_db.length 
  # else
  #   @id = 0
  # end

  # p "id value: #{@id}"

  def initialize(name, address)

    # p "id db #{$cus_id_db}"
    # $cus_id_db.push($cus_id_db[-1] + 1)
    # p "id db #{$cus_id_db}"
    @hash = {
      :Name => name,
      :Address  => address,
      :ID => sprintf("%20.10f", Time.now.to_f).delete('.').to_i.to_s(36)
    }

  end
  def read
    return @hash
  end
end

class Equipment
  # if $equipment_id_db.length > 0
  #   @id = $equipment_id_db.length 
  # else
  #   @id = 0
  # end

  def initialize(name, price)
    @hash = {
      :Equipment => name,
      :DailyHirePrice => price,
      :Status => "Available",
      :HiredBy => "n/a",
      :HireDate => "n/a",
      :DueBackDate => "n/a",
      :ID => id = sprintf("%20.10f", Time.now.to_f).delete('.').to_i.to_s(36),
    }

    # $equipment_id_db.push($equipment_id_db[-1] + 1)

  end
  def read
    return @hash
  end
end



while $menu_input != "exit"

  menu

end








