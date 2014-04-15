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
  
  describe "edit" do
    
    let(:group) { FactoryGirl.create(:group, coach: coach, name:"test", description: "desc")}
    
    before do
      visit edit_group_path(group)
    end
    

    describe "page" do
      it { should have_content("Update group information") }
    end

    describe "with invalid information" do
      before do
        fill_in "Name", with: ""
        click_button "Save changes" 
      end
      it { should have_content('error') }
    end
    
    describe "with valid information" do
      before do
        fill_in "Name", with: "valid name"
        fill_in "Description", with: "valid description"
        click_button "Save changes" 
      end
      it { should have_content('Group updated') }
    end
    
    describe "cannot edit other's group" do
      let(:coach2) { FactoryGirl.create(:coach) }
      before do
        sign_in coach2
        visit edit_group_path(group)
      end
      it { should_not have_content("Update group information") }
    end
  end
  
  describe "show" do
    let(:group) { FactoryGirl.create(:group, coach: coach, name:"test", description: "desc")}
    
    describe "should have group name, description, edit, delete" do
      before { visit group_path(group) }
      it { should have_content(group.name) }
      it { should have_content(group.description) }
      it { should have_link('edit', href: edit_group_path(group)) }
      it { should have_link('delete', href: group_path(group)) }
      
    end
    
    describe "should not see edit/delete link of other coach's group" do
      let(:coach2) { FactoryGirl.create(:coach) }
      before do
        sign_in coach2
        visit group_path(group)
      end
      it { should_not have_link("edit") }
      it { should_not have_link("delete") }
    end
  end
  
  describe "delete" do
    let(:group) { FactoryGirl.create(:group, coach: coach, name:"test", description: "desc")}
    before { visit group_path(group) }
    it "should be able to delete a group" do
      expect do
        click_link('delete')
          end.to change(coach.groups, :count).by(-1)
    end
  end
end