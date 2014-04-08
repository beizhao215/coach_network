require 'spec_helper'

describe "StudentPages" do
  
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
  end
  
end
