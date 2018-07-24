# let's put all students into an array
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Kreuger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
def print_this(names)
  names.each do |name|
    puts name
  end
end
def print_footer(names)
  print "Overall, we have #{names.count} great students"
end
#nothing happends until we call the methods
print_header
print_this(students)
print_footer(students)