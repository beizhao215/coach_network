require 'spec_helper'

describe Post do
  let(:coach) { FactoryGirl.create(:coach) }
  let(:student) { FactoryGirl.create(:student) }
  let(:group) { FactoryGirl.create(:group, coach: coach)}
  before do
    @post = group.posts.build(content: "Lorem ipsum", coach_id: coach.id)
  end
  
  subject { @post }
  
  it { should respond_to(:content) }
  it { should respond_to(:coach_id) }
  it { should respond_to(:group_id) }
  it { should respond_to(:coach) }
  it { should respond_to(:student) }
  it { should respond_to(:group) }
  
  
  
  it { should be_valid }

  describe "when both coach_id and student_id are not present" do
    before do
      @post.coach_id = nil
      @post.student_id = nil
    end
    it { should_not be_valid }
  end
  
  describe "when group_id is not present" do
    before do
      @post.group_id = nil
    end
    it { should_not be_valid }
  end
  
  describe "with blank content" do
    before { @post.content = " " }
    it { should_not be_valid }
  end
  
  describe "with content that is too long" do
    before { @post.content = "a" * 141 }
    it { should_not be_valid }
  end
  
end
