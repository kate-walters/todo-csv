require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/todo'
require_relative './spec_helper'

class TodoTest < MiniTest::Test

  def todo_setup
    $input  = [] # Reset all input between tests
    $output = [] # Reset all messages between tests
    @todo = Todo.new('spec/test_todos.csv') # Given
  end

  def test_view_todos_prints_unfinished_header
    todo_setup # Given
    @todo.view_todos # When
    assert($output.include?("Unfinished"), "'Unfinished' was not printed") # Then
    #We are asserting that the string 'Unfinished' is somewhere in the output of the program.
    #That somewhere in the view_todos methos we said `puts "Unfinished"`
  end

  # ============
  # ==============================================================
  # -- UNCOMMENT EACH TEST WHEN YOU GET THE ONE BEFORE IT TO PASS
  # ==============================================================
  # ============

  def test_view_todos_prints_completed_header
    todo_setup # Given
    @todo.view_todos # When
    assert($output.include?("Completed"), "Completed' was not printed") # Then
  end

  def test_view_todos_prints_todos
    todo_setup # Given
    @todo.view_todos #When (Make sure the method you are testing is being called)

    # IF you want to debug, use the constant STDOUT.puts to print
    # STDOUT.puts @todo.todos
    # STDOUT.puts $output.inspect
    assert_equal("1) finish homework", $output[1], "The todo found in 'test_todos.csv' were not printed") # Then
  end

  def test_add_todo_prints_prompt
    todo_setup # Given
    @todo.add_todo
    assert_equal("Name of Todo > ", $output.last, "The last message printed should have been the prompt")
  end
#require 'pry'
  def test_add_todo_creates_new_todo
    todo_setup # Given
    $input.push("make this test pass") # So we can test input (can't use gets in a test)
    @todo.add_todo
    assert_equal("make this test pass,no\n", @todo.todos[1].to_s, "The 2nd todo in todos should have been 'make this test pass'")
  end

  def test_mark_todo_prints_prompt
    todo_setup # Given
    @todo.mark_todo
    assert_equal("Which todo have you finished?", $output.last, "The last message was not asking what todo they have finished")
  end

  def test_mark_todo_changes_todo
    todo_setup # Given
    $input.push('1')
    @todo.mark_todo
    assert_equal("finish homework,yes\n", @todo.todos[0].to_s, "The first todo in todos was not 'finish homework'")
  end
end
