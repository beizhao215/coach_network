require 'spec_helper'

describe "Coach pages" do

  subject { page }
  
  describe "profile page" do
    let(:coach) { FactoryGirl.create(:coach) }
    before { visit coach_path(coach) }

    it { should have_content(coach.name) }
  end

  describe "signup page" do
    before { visit coach_signup_path }

    it { should have_content('Coach sign up') }
  end
  
  describe "signup" do

    before { visit coach_signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a coach" do
        expect { click_button submit }.not_to change(Coach, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example Coach"
        fill_in "Email",        with: "coach@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a coach" do
        expect { click_button submit }.to change(Coach, :count).by(1)
      end
    end
  end
end