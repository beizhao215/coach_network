require 'spec_helper'

describe Student do

  before do
     @student = Student.new(name: "Example Student", email: "student@example.com",
                                  password: "foobar", password_confirmation: "foobar")
  end 

  subject { @student }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:enrollments) }
  
  
  
  
  it { should be_valid }

  describe "when name is not present" do
    before { @student.name = " " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @student.email = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @student.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @student.email = invalid_address
        expect(@student).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @student.email = valid_address
        expect(@student).to be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      student_with_same_email = @student.dup
      student_with_same_email.email = @student.email.upcase
      student_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before do
      @student = Student.new(name: "Example student", email: "student@example.com",
                         password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @student.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @student.password = @student.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @student.save }
    let(:found_student) { Student.find_by(email: @student.email) }

    describe "with valid password" do
      it { should eq found_student.authenticate(@student.password) }
    end

    describe "with invalid password" do
      let(:student_for_invalid_password) { found_student.authenticate("invalid") }

      it { should_not eq student_for_invalid_password }
      specify { expect(student_for_invalid_password).to be_false }
    end
  end
  
  describe "remember token" do
    before { @student.save }
    its(:remember_token) { should_not be_blank }
  end
end
