require 'spec_helper'

describe "Creating todo lists" do
  def create_todo_list(options={})
    expect(TodoList.count).to eq(0)
    options[:title] ||= "My Todo list"
    options[:description] ||= "This is my todo list"
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end
  it "redirects to the todo list index page on success" do
    create_todo_list
    expect(page).to have_content("My Todo list")
  end

  it "displays an error when the todo list haas no title" do
    create_todo_list title: ""
    expect(page).to have_content("error")
    expect(page).to have_content("New Todo List")

    visit "/todo_lists"
    expect(page).to_not have_content("This is my todo list")
  end

  it "displays an error when the todo list haas a title less than three characters" do
    create_todo_list title: "Hi"
    expect(page).to have_content("error")
    expect(page).to have_content("New Todo List")

    visit "/todo_lists"
    expect(page).to_not have_content("This is what I'm doing today")
  end

  it "displays an error when the todo list has no description" do
    create_todo_list description: ""
    expect(page).to have_content("error")
    expect(page).to have_content("New Todo List")

    visit "/todo_lists"
    expect(page).to_not have_content("This is what I'm doing today")
  end

  it "displays an error when the todo list has a description less than 5 characters" do
    create_todo_list description: "helo"
    expect(page).to have_content("error")
    expect(page).to have_content("New Todo List")

    visit "/todo_lists"
    expect(page).to_not have_content("This is what I'm doing today")
  end
end
