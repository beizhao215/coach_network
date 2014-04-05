require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
  end
  
  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('div.alert.alert-error') }
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:coach) { FactoryGirl.create(:coach) }
      before do
        fill_in "Email",    with: coach.email.upcase
        fill_in "Password", with: coach.password
        click_button "Sign in"
      end

      it { should have_link('Profile',     href: coach_path(coach)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
end
