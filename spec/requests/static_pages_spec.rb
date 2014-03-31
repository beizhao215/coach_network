require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should be a valid page have content 'homepage'" do
      visit root_path
      expect(page).to have_content('homepage')
    end
  end
  
  describe "About page" do
      it "should be a valid page have content 'about'" do
        visit about_path
        expect(page).to have_content('about')
      end
    end
end
