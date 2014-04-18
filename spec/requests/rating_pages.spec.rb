require 'spec_helper'

describe "Rating Page" do
  subject { page }
  
  let(:coach) { FactoryGirl.create(:coach) }
  let(:student) { FactoryGirl.create(:student) }
  let(:group) { FactoryGirl.create(:group, coach: coach)}
  before do
    @rating = group.ratings.build(student_id: student.id, score: 5)
  end
  
  describe "un-enrolled student can see average rating, cannot see your rating " do
    before { visit group_path(group) }
    it { should have_content("Average rating") }
    it { should_not have_content("Your rating") }
  end
  
  describe "enrolled student can see your rating" do
    before do
      student.enroll!(group)
      visit group_path(group)
    end
    it { should_not have_content("Your rating") }
  end
end
