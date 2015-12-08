require 'spec_helper'

describe "Deleting TodoLists" do

  let!(:todo_list) { TodoList.create(title: "Groceries", description: "A Grocery List") }

  it "is successful when clicking the Destroy link" do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Destroy"
    end
    expect(page).to_not have_content(todo_list.title)
    expect(TodoList.count).to eq(0)
  end
end
