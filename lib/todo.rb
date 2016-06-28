require_relative 'assignment_helper'
require 'csv'

class Todo
  include AssignmentHelper

  def initialize(file_name)
    @file_name = file_name #Don't touch this line or var
    #You will need to read from your CSV here and assign them to the @todos variable. make sure headers are set to true
    @todos = CSV.read(@file_name, {headers: true})
  end

  def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      view_todos

      puts
      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete 4) Edit 5) Delete"
      print " > "
      action = get_input.to_i
      case action
      when 1 then exit
      when 2 then add_todo
      when 3 then mark_todo
      when 4 then edit_todo
      when 5 then delete_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
    end
  end

  def view_todos
    puts "Unfinished"
    @todos.each_with_index do |todo, index|
      puts "#{index + 1} #{todo[0]}" if todo[1] == "no"
    end
    puts "Completed"
    @todos.each_with_index do |todo, index|
      puts "#{index + 1} #{todo[0]}" if todo[1] == "yes"
    end
  end

  def add_todo
    puts "Name of Todo > "
    @todos.push(get_input,"no")
    view_todos
  end

  def mark_todo
    print "Which todo have you finished?"
    x = get_input.to_i - 1
    current = self.todos[x]
    @todos[x][1] = "yes"
    [current] << [x]
  end

  def edit_todo
    print "Which todo do you need to edit?"
    x = get_input.to_i - 1
    edit = self.todos[x].map
    @todos[edit] = get_input
    [edit] << [x]
  end

  def delete_todo
    print "Which todo do you need to delete?"
    x = get_input.to_i - 1
    delete = self.todos[x].delete
    [delete] << [x]
  end

  def todos
    @todos
  end

  private # Don't edit the below methods, but use them to get player input and to save the csv file
  def get_input
    STDIN.gets.chomp
  end

  def save!
    File.write(@file_name, @todos.to_csv)
  end
end
