require 'spec_helper'

describe "Coach pages" do

  subject { page }
  
  describe "index" do
    let(:coach) { FactoryGirl.create(:coach) }
    before(:each) do
      sign_in coach
      visit coaches_path
    end

    it { should have_content('All coaches') }

    it "should list each coach" do
      Coach.all.each do |coach|
        expect(page).to have_selector('li', text: coach.name)
      end
    end
    
    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin coach" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit coaches_path
        end

        it { should have_link('delete', href: coach_path(Coach.first)) }
        it "should be able to delete another coach" do
          expect do
            click_link('delete', match: :first)
          end.to change(Coach, :count).by(-1)
        end 
        it { should_not have_link('delete', href: coach_path(admin)) }
      end
    end
  end
  
  describe "profile page" do
    let(:coach) { FactoryGirl.create(:coach) }
    let!(:group1) { FactoryGirl.create(:group, coach: coach, name: "football", description: "play football together!") }
    
    before { visit coach_path(coach) }

    it { should have_content(coach.name) }
    
    describe "groups" do
      it { should have_content(group1.name) }
      it { should have_content(group1.description) }
    end
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
      
      describe "after saving the user" do
        before { click_button submit }
        let(:coach) { Coach.find_by(email: 'coach@example.com') }

        it { should have_link('Sign out') }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end
  
  describe "edit" do
    let(:coach) { FactoryGirl.create(:coach) }
    before do
      sign_in coach
      visit edit_coach_path(coach)
    end

    describe "page" do
      it { should have_content("Update your profile") }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      let(:new_subject) { "tennis" }
      let(:new_location) { "plano" }
      
      before do
        fill_in "Name",             with: new_name
        fill_in "Email",            with: new_email
        fill_in "Subject",          with: new_subject
        fill_in "Location",         with: new_location
        fill_in "Password",          with: coach.password
        fill_in "Confirm Password",         with: coach.password
        click_button "Save changes"
      end

      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(coach.reload.name).to  eq new_name }
      specify { expect(coach.reload.email).to eq new_email }
      specify { expect(coach.reload.subject).to eq new_subject }
      specify { expect(coach.reload.location).to eq new_location }
      
      
    end
  end
end