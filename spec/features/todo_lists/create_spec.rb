RSpec.configure do |c|
        c.expose_current_running_example_as :example
      end

require 'spec_helper'

describe "Creating todo lists" do 
  def create_todo_list(options={})
    options [:title] ||= "My Todo List"
    options [:description] ||= "This is what I'm doing today"
    
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")
    
    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  it "redirects to the todo list index page on success" do
    create_todo_list     
    expect(page).to have_content("My Todo List")
  end

  it "displays an error when to do list has no title" do 
    expect(TodoList.count()).to eq(0)  

    create_todo_list title: ""
    expect(page).to have_content("error")
    expect(TodoList.count()).to eq(0)  
    
    visit "/todo_lists"
    expect(page).to_not have_content("This is what I'm doing today")
  end

  it "displays an error when to do title has less than three characters" do
    expect(TodoList.count()).to eq(0)  

    create_todo_list title: "hi"
    expect(page).to have_content("error")
    expect(TodoList.count()).to eq(0)  
    
    visit "/todo_lists"
    expect(page).to_not have_content("This is what I'm doing today")
  end
end

