require 'spec_helper'

describe "StudentPages" do
  
  subject { page }
  
  describe "profile page" do
    let(:student) { FactoryGirl.create(:student) }
    before { visit student_path(student) }

    it { should have_content(student.name) }
  end
  
  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
  end
  
  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a student" do
        expect { click_button submit }.not_to change(Student, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example Student"
        fill_in "Email",        with: "es@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      it "should create a user" do
        expect { click_button submit }.to change(Student, :count).by(1)
      end
    end
  end
end
