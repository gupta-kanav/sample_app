require 'spec_helper'

describe "User pages" do


  subject { page }
  
  describe "index" do
      before do
        sign_in FactoryGirl.create(:user)
        FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
        FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
        visit users_path
      end

      it { should have_title('All users') }
      it { should have_content('All users') }

      it "should list each user" do
        User.all.each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
   it { should have_title('Sign up') }
  end
  
  describe "profile page" do
    
    let(:user) { FactoryGirl.create(:user) }
    # Replace with code to make a user variable
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
  
  describe "signup page" do

      before { visit signup_path }

      let(:submit) { "Create my account" }

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
      end
      
      describe "with valid information" do
            before do
              fill_in "Name",         with: "Example User"
              fill_in "Email",        with: "user@example.com"
              fill_in "Password",     with: "foobar"
              fill_in "Confirmation", with: "foobar"
            end

            it "should create a user" do
              expect { click_button submit }.to change(User, :count).by(1)
            end
          end
        end
        
        
        describe  "edit" do
          let(:user) {FactoryGirl.create(:user)}
          
          before do
            sign_in user
            visit edit_user_path(user)
        end
        
      
      describe  "page" do
        
        it { should have_content ("Update your profile ") }
        it { should have_title("Edit User") }
        it { should have_link('change',:href=>'http://gravatar.com/emails')}
      end
      
      describe "with invalid information" do
        before { click_button "Save Changes" }
        it { should have_content('Error') }
        
      end
      
    end
        
end