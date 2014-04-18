require 'spec_helper'

describe Message do
  let(:student) { FactoryGirl.create(:student) }
  let(:coach) { FactoryGirl.create(:coach) }
  
  before do
    # This code is not idiomatically correct.
    @message = student.messages.build(title:"test", content: "Lorem ipsum", coach_id:coach.id)
  end

  subject { @message }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:student_id) }
  it { should respond_to(:coach_id) }
  its(:student) { should eq student}
  
  it { should be_valid }
  
end
