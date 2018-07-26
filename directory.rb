def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" 
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      # input the students
      students = input_students
    when "2"
      # show the students
      if students.length > 0
        print_header
        print_this(students)
        print_footer(students)
      end
    when "9"
      exit # this will cause program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

def input_students

  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create empty array
  students = []

  # get the first name
  name = gets.chomp

  if !name.empty? 
    # ask for cohort
    puts "What cohort?"
    cohort = gets.chomp

    puts "What is their country of birth?"
    country_born = gets.chomp

    puts "What is their favourite sport?"
    sport = gets.chomp
  end

  # while the name is not empty, repeat this code
  while !name.empty? do

    # add the student hash to the array 
    students << {name: name, country_born: country_born, sport: sport, cohort: cohort.to_s}
    if students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{students.count} students"
    end

    # get another name from the user
    name = gets.chop

    # break out of loop if name is empty
    if name == ""
      break
    end

    puts "What is their country of birth?"
    country_born = gets.chomp

    puts "What is their favourite sport?"
    sport = gets.chomp

    puts "What cohort?"
    cohort = gets.chomp

  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print_this(students)
  counter = 0

  students_by_cohort = {}

  students.each do |student|
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

def print_footer(names)
  if names.length == 1
    puts "Overall, we have 1 great student".center(50)
  else
    puts "Overall, we have #{names.count} great students".center(50)
  end
end

#nothing happends until we call the methods
interactive_menu