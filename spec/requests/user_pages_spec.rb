require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "signup" do
    before { visit signup_path }
    
    describe "error messages" do
      before { click_button "Sign up" }
      let(:error) { 'errors prohibited this user from being saved' }
      
      it { should have_selector('title', text: 'Sign up') }
      it { should have_content(error) }
    end

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Sign up" }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example user"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      describe "after saving the user" do
        before { click_button "Sign up" }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.flash.success', text: 'Welcome') }
      end
          
      it "should create a user" do
        expect { click_button "Sign up" }.to change(User, :count).by(1)
      end
    end
  end
  
  describe "Signup page" do
    before{ visit signup_path }
    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end
  
  describe "profile page" do
    # some code here should make a user variable
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_selector('h1',     text: user.name) }
    it { should have_selector('title',  text: user.name) }
  end
end
