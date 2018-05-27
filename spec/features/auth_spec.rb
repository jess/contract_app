require 'rails_helper'

describe "auth" do
  it 'can create an account' do
    visit root_path
    click_link "Log In"
    click_link "Sign up"
    fill_in "Email", :with => "jess@bb.com"
    fill_in "Password", :with => "jess123abc"
    fill_in "Password confirmation", :with => "jess123abc"
    click_on "Sign up"
    expect(page).to have_content "You have signed up successfully"
    click_link "Log Out"
    expect(page).to have_content "Signed out successfully"
    click_link "Log In"
    fill_in "Email", :with => "jess@bb.com"
    fill_in "Password", :with => "jess123abc"
    click_on "Log in"
    expect(page).to have_content "Signed in successfully"
  end
end
