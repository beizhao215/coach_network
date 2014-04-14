require 'spec_helper'

describe "GroupPages" do
  
  subject { page }
  let(:coach) { FactoryGirl.create(:coach) }
  before { sign_in coach }
  
  describe "Group creation" do
    before { visit coach_path(coach) }
    
    it { should have_link('Start New Group') }
    
    describe "create a group" do
      before { click_link "Start New Group"}
      it { should have_content"Create a new group"}
      
      describe "with invalid information" do
        it "should not create a group" do
          expect { click_button "Create Group!" }.not_to change(coach.groups, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name",         with: "test course name"
          fill_in "Description",        with: "sample description of the course"
        end

        it "should create a group" do
          expect { click_button "Create Group!" }.to change(coach.groups, :count).by(1)
        end
      
      end
    end
  end
      
end
