require 'spec_helper'

describe Coach do
  before do
    @coach = Coach.new(name: "Example Coach", email: "coach@example.com",
                        password: "foobar", password_confirmation: "foobar") 
  end
  
  subject { @coach }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }  
  it { should respond_to(:phone) }
  it { should respond_to(:subject) }
  it { should respond_to(:location) }
  it { should respond_to(:self_introduction) }
  it { should respond_to(:course_introduction) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:groups) }
  it { should respond_to(:posts) }
  
  
  
  
  
  it { should be_valid }
  it { should_not be_admin }
  
  describe "with admin attribute set to 'true'" do
    before do
      @coach.save!
      @coach.toggle!(:admin)
    end

     it { should be_admin }
  end
  
  describe "when name is not present" do
    before {@coach.name=""}
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before {@coach.email=""}
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @coach.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "return value of authenticate method" do
    before { @coach.save }
    let(:found_coach) { Coach.find_by(email: @coach.email) }

    describe "with valid password" do
      it { should eq found_coach.authenticate(@coach.password) }
    end

    describe "with invalid password" do
      let(:coach_for_invalid_password) { found_coach.authenticate("invalid") }

      it { should_not eq coach_for_invalid_password }
      specify { expect(coach_for_invalid_password).to be_false }
    end
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @coach.email = invalid_address
        expect(@coach).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @coach.email = valid_address
        expect(@coach).to be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @coach.dup
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before do
      @coach = Coach.new(name: "Example User", email: "user@example.com",
                         password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @coach.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "remember token" do
    before { @coach.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "group associations" do
    before { @coach.save }
    let!(:group) do
      FactoryGirl.create(:group, coach:@coach)
    end
    
    it "should destroy associated groups" do
      groups = @coach.groups.to_a
      @coach.destroy
      expect(groups).not_to be_empty
      groups.each do |group|
        expect(Group.where(id: group.id)).to be_empty
      end
    end
  end
end
