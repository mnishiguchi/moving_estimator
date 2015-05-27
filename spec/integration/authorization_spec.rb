require 'rails_helper'

describe "authorization", type: :feature do

  describe "for non-logged-in users" do
    let(:user) { FactoryGirl.create(:user) }

    describe "in the Users controller" do

      describe "visiting the edit page" do
        before { visit edit_user_registration_path }

        it "redirects to login page" do
          expect(current_path).to eq new_user_session_path
          expect(page).to have_title('Log in')
        end

        describe "after logging in" do
          before { valid_login(user) }

          it "renders the desired protected page" do
            expect(current_path).to eq edit_user_registration_path
            expect(page).to have_title('Edit User')
          end
        end
      end

      describe "visiting the user index" do
        before { visit users_path }

        it "redirects to root page" do
          expect(current_path).to eq root_path
        end

        describe "after logging in" do
          before { valid_login(user) }

          it "redirects to root page" do
            expect(current_path).to eq root_path
          end
        end
      end
    end
  end
end
  # describe "for admin users" do
  #   let(:user) { FactoryGirl.create(:user) }

  #   describe "visiting all users page" do

  #     before(:each) do
  #       user.update_attribute(:admin, true)
  #       valid_login user
  #       visit users_path
  #     end

  #     it { should have_title('All users') }
  #     it { should have_content('All users') }

  #     describe "pagination" do
        # before(:all) { 30.times { FactoryGirl.create(:user) } }
        # after(:all)  { User.delete_all }

        # it { should have_selector('div.pagination') }

        # it "should list each user" do
        #   User.paginate(page: 1).each do |user|
        #     expect(page).to have_selector('li', text: user.name)
        #   end
        # end
#       end
#     end
#   end
# end
