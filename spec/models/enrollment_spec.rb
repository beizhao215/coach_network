require 'spec_helper'

describe Enrollment do
  let(:coach) { FactoryGirl.create(:coach) }
  let(:group) { FactoryGirl.create(:group, name: "test", description:"description") }
  let(:student) { FactoryGirl.create(:student) }
  let(:enrollment) { group.enrollments.build(student_id: student.id) }

  subject { enrollment }

  it { should be_valid }
  describe "student methods" do
    it { should respond_to(:group) }
    it { should respond_to(:student) }
    its(:group) { should eq group }
    its(:student) { should eq student }
  end
  
  describe "when group id is not present" do
    before { enrollment.group_id = nil }
    it { should_not be_valid }
  end

  describe "when student id is not present" do
    before { enrollment.student_id = nil }
    it { should_not be_valid }
  end
  
  describe "enrolling" do
    before { student.enroll!(group) }
    subject { student }
    

    describe "should enroll the student to the group" do
      it { should be_enrolling(group) }
    end
    
    describe "and drop" do
      before { student.drop!(group) }
      it { should_not be_enrolling(group) }
      its(:enrollments) { should_not include(group) }
    end
  end
  
  
end
