require 'spec_helper'

describe Group do
  
  let(:coach) { FactoryGirl.create(:coach) }
  before do
    @group = Group.new(name:"tennis club",description:"for beginners just started playing tennis", coach_id: coach.id)
  end
  
  subject { @group }
  
  it { should respond_to(:description) }
  it { should respond_to(:coach_id) }
  it { should be_valid }
  
  describe "when coach_id is not present" do
    before { @group.coach_id = nil }
    it { should_not be_valid }
  end
  
end
