require 'csv'

@students = [] # empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  
  # get the first name
  name = STDIN.gets.chomp

  if !name.empty? 
    # ask for cohort
    puts "What cohort?"
    cohort = STDIN.gets.chomp
    puts "What is their country of birth?"
    country_born = STDIN.gets.chomp
    puts "What is their favourite sport?"
    sport = STDIN.gets.chomp
  end
  
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    add_info_to_students(name, cohort, country_born, sport)
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    # get another name from the user
    name = STDIN.gets.chomp
    # break out of loop if name is empty
    if name == ""
      break
    end
    puts "What cohort?"
    cohort = STDIN.gets.chomp
    puts "What is their country of birth?"
    country_born = STDIN.gets.chomp
    puts "What is their favourite sport?"
    sport = STDIN.gets.chomp
  end
end

def print_menu
  # 1. print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" 
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    # input the students
    input_students
  when "2"
    # show the students
    if @students.length > 0
      show_students
    end
  when "3"
    save_students
    puts " "
  when "4"
    puts "Which file would you like to load?"
    user_input = STDIN.gets.chomp
    if File.exists?(user_input)
      load_students(user_input)
      puts "Students loaded"
      puts " "
    else
      puts "Sorry, that file doesn't exist."
    end
    
  when "9"
    puts "Exiting..."
    exit # this will cause program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "================================".center(50)
end

def print_students_list
  counter = 0

  students_by_cohort = {}

  @students.each do |student|
    cohort = student[:cohort]

    if students_by_cohort[cohort] == nil
      students_by_cohort[cohort] = []
    end

    students_by_cohort[cohort].push(student[:name])
  end

  students_by_cohort.map do | key, value |
    puts key.to_s.center(50)
    puts "-------------".center(50)
    value.each do |name|
      puts name.center(50)
    end
    puts ""

  end
end

def print_footer
  if @students.length == 1
    puts "Overall, we have 1 great student".center(50)
  else
    puts "Overall, we have #{@students.count} great students".center(50)
  end
end

def save_students
  puts "Where would you like to save?"
  user_input = STDIN.gets.chomp
  
  #open the file for writing using csv library
  CSV.open(user_input, "w") do |file|
    #iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:country_born], student[:sport]]
      
      # push array into CSV file
      file << student_data
    end
  end
  puts "Succesfully saved in #{user_input}."
end

def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    file_to_students_array(file)
  end
end

def file_to_students_array(file)
  file.readlines.each do |line|
    name, cohort, country_born, sport = line.chomp.split(",")
    add_info_to_students(name, cohort, country_born, sport)
  end
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil? # load students.csv by default if no file is given
    load_students
  elsif File.exists?(filename) #if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exists
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def add_info_to_students(name, cohort, country, sport)
  @students << {name: name, cohort: cohort.to_sym, country_born: country, sport: sport}
end

#nothing happends until we call the methods
try_load_students
interactive_menu