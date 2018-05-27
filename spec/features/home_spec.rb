require 'rails_helper'

describe "home" do
  it 'opens the page' do
    visit root_path
    expect(page).to have_css("h1", text: "Home")
  end
end
