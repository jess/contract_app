require 'rails_helper'

describe "home" do
  it 'opens the page' do
    visit root_path
    expect(page).to have_css("h1", text: "Home")
  end

  it 'can test javascript', js: true do
    visit root_path
    expect(page).to have_content "Hello Vue!"
  end
end
