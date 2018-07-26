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
    @students << {name: name, country_born: country_born, sport: sport, cohort: cohort.to_s}
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
  when "4"
    load_students
  when "9"
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
  puts "-------------".center(50)
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
    # while counter < students.length 
    #   puts "#{students[counter][:name]} (#{students[counter][:cohort]} cohort)".center(50)
    #   counter += 1
    # end
end

def print_footer
  if @students.length == 1
    puts "Overall, we have 1 great student".center(50)
  else
    puts "Overall, we have #{@students.count} great students".center(50)
  end
end

def save_students
  #open the file for writing
  file = File.open("students.csv", "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) #if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exists
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

#nothing happends until we call the methods
try_load_students
interactive_menu