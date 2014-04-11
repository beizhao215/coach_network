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
    
    describe "coach with valid information" do
      let(:coach) { FactoryGirl.create(:coach) }
      before { sign_in coach }

      it { should have_link('Coaches',       href: coaches_path) }
      it { should have_link('Profile',     href: coach_path(coach)) }
      it { should have_link('Settings',    href: edit_coach_path(coach)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
    
    describe "student with valid information" do
      let(:student) { FactoryGirl.create(:student) }
      before { sign_in student }

      it { should have_link('Coaches',       href: coaches_path) }
      it { should have_link('Profile',     href: student_path(student)) }
      it { should have_link('Settings',    href: edit_student_path(student)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
  
  describe "authorization" do

    describe "for non-signed-in coaches" do
      let(:coach) { FactoryGirl.create(:coach) }

      describe "in the Coaches controller" do

        describe "visiting the edit page" do
          before { visit edit_coach_path(coach) }
          it { should have_content('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch coach_path(coach) }
          specify { expect(response).to redirect_to(signin_path) }
        end
        
        describe "visiting the coach index" do
          before { visit coaches_path }
          it { should have_content('Sign in') }
        end
      end
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_coach_path(coach)
          fill_in "Email",    with: coach.email
          fill_in "Password", with: coach.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_content('Update your profile')
          end
        end
      end
    end
    
    describe "for non-signed-in students" do
      let(:student) { FactoryGirl.create(:student) }

      describe "in the Students controller" do

        describe "visiting the edit page" do
          before { visit edit_student_path(student) }
          it { should have_content('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch student_path(student) }
          specify { expect(response).to redirect_to(signin_path) }
        end
        
        describe "visiting the coach index" do
          before { visit coaches_path }
          it { should have_content('Sign in') }
        end
      end
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_student_path(student)
          fill_in "Email",    with: student.email
          fill_in "Password", with: student.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_content('Update your profile')
          end
        end
      end
    end
    
    describe "as wrong coach" do
      let(:coach) { FactoryGirl.create(:coach) }
      let(:wrong_coach) { FactoryGirl.create(:coach, email: "wrong@example.com") }
      before { sign_in coach, no_capybara: true }

      describe "submitting a GET request to the Coaches#edit action" do
        before { get edit_coach_path(wrong_coach) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Coaches#update action" do
        before { patch coach_path(wrong_coach) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
    
    describe "as wrong student" do
      let(:student) { FactoryGirl.create(:student) }
      let(:wrong_student) { FactoryGirl.create(:student, email: "wrong@example.com") }
      before { sign_in student, no_capybara: true }

      describe "submitting a GET request to the Students#edit action" do
        before { get edit_student_path(wrong_student) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Students#update action" do
        before { patch student_path(wrong_student) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
    
    describe "as non-admin user" do
      let(:coach) { FactoryGirl.create(:coach) }
      let(:non_admin) { FactoryGirl.create(:coach) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Coaches#destroy action" do
        before { delete coach_path(coach) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end
  end
end
