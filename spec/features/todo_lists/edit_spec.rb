require 'spec_helper'

describe "Editing TodoLists" do

  let!(:todo_list) { TodoList.create(title: "Groceries", description: "A Grocery List") }

  def update_todo_list(options={})
    options[:title] ||= "My Todo list"
    options[:description] ||= "This is my todo list"
    todo_list = options[:todo_list]
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end
    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end

  it "updates a todo list successfully with correct information" do
      todo_list = TodoList.create(title: "Groceries", description: "A Grocery List")
      update_todo_list todo_list: todo_list,
                       title: "New Title",
                       description: "New Description"
      todo_list.reload
      expect(page).to have_content("Todo list was successfully updated")
      expect(todo_list.title).to eq("New Title")
      expect(todo_list.description).to eq("New Description")
  end

  it "displays an error when the todo list haas no title" do
    update_todo_list todo_list: todo_list,
                     title: "",
                     description: "New Description"
    expect(page).to have_content("error")
  end

  it "displays an error when the todo list has title less than three characters" do
    update_todo_list todo_list: todo_list,
                     title: "Hi",
                     description: "New Description"
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content("error")
  end

  it "displays an error when the todo list has no description" do
    update_todo_list todo_list: todo_list,
                     title: "New Title",
                     description: ""
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content("error")
  end

  it "displays an error when the todo list has description less than five characters" do
    update_todo_list todo_list: todo_list,
                     title: "New Title",
                     description: "helo"
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content("error")
  end
end
