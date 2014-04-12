require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should be a valid page have content 'homepage'" do
      visit root_path
      expect(page).to have_content('Better Skills Start Here')
    end
  end
  
  describe "About page" do
      it "should be a valid page have content 'about'" do
        visit about_path
        expect(page).to have_content('Coach Network by Bei Zhao, Ryan Wang')
      end
    end
end
