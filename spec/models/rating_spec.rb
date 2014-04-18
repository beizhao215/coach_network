require 'spec_helper'

describe Rating do
  let(:coach) { FactoryGirl.create(:coach) }
  let(:student) { FactoryGirl.create(:student) }
  let(:group) { FactoryGirl.create(:group, coach: coach)}
  before do
    @rating = group.ratings.build(student_id: student.id, score: 5)
  end
  
  subject { @rating }
  
  it { should respond_to(:score) }
  it { should respond_to(:student_id) }
  it { should respond_to(:group_id) }
  
  
  it { should be_valid }
end
  
