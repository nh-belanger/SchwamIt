require "rails_helper"

feature "Admin authorization" do
  before(:each) do
    user = FactoryGirl.create(:user, role: "admin")
    user2 = FactoryGirl.create(:user)
    FactoryGirl.create(:item, user: user2)
    sign_in user
  end

  xscenario "Admin navigates to the index page" do
    item = Item.first

    visit root_path

    expect(page).to have_content "Add a new Thing"
    expect(page).to have_content item.title
    expect(page).to_not have_content "Sign in to Submit a Thing"
  end
  scenario "Admin navigates to an item's show page" do
    item = Item.first

    visit "/items/#{item.id}"

    expect(page).to have_content item.title
    expect(page).to have_content item.description
    expect(page).to have_link "Edit Item"
    expect(page).to have_link "Delete"
  end

  scenario "Admin navigates to an item's edit page" do
    item = Item.first

    visit "/items/#{item.id}"
    click_link "Edit Item"

    expect(page).to have_link "Delete"
    expect(page).to have_button "Update Item"
  end
end
