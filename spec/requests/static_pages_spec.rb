require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should be a valid page have content 'homepage'" do
      visit '/static_pages/home'
      expect(page).to have_content('homepage')
    end
  end
  
  describe "About page" do
      it "should be a valid page have content 'about'" do
        visit '/static_pages/about'
        expect(page).to have_content('about')
      end
    end
end
