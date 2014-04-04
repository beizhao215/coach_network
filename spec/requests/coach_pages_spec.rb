require 'spec_helper'

describe "Coach pages" do

  subject { page }

  describe "signup page" do
    before { visit coach_signup_path }

    it { should have_content('Coach sign up') }
   
  end
end