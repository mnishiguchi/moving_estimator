require 'rails_helper'

describe "Authorization", type: :feature do

  describe "for non-logged-in users" do
    let(:user) { FactoryGirl.create(:user) }

    describe "protected links" do
      before { visit root_path }
      it { expect(page).not_to have_link "Admin" }
      it { expect(page).not_to have_link user.username }

      describe "after logging in" do
        before do
          log_in_as(user)
          visit root_path
        end

        it { expect(page).not_to have_link "Admin" }
        it { expect(page).to have_link user.username }
      end
    end

    describe "visiting protected pages" do

      describe "the edit user page" do
        before { visit edit_user_registration_path }

        it "redirects to login page" do
          expect(current_path).to eq new_user_session_path
          expect(page).to have_title('Log in')
        end

        describe "after logging in" do
          before { log_in_as(user) }

          it "renders the desired protected page" do
            expect(current_path).to eq edit_user_registration_path
            expect(page).to have_title('Edit User')
          end
        end
      end

      describe "the all user page" do
        before { visit users_path }

        it "redirects to root page" do
          expect(current_path).to eq root_path
        end

        context "after loggin in as non-admin" do
          before do
            log_in_as(user)
            visit users_path
          end

          it "redirects to root page" do
            expect(current_path).to eq root_path
          end
        end

        context "after loggin in as admin" do
          before do
            user.update_attribute(:admin, true)
            log_in_as(user)
            click_link "Admin"
            click_link "Users"
          end
          it { expect(page).to have_title('All users') }
          it { expect(page).to have_content('All users') }
          it { expect(current_path).to eq users_path }

          describe "pagination" do
            before(:all) { 30.times { FactoryGirl.create(:user) } }
            after(:all)  { User.delete_all }

            it { expect(page).to have_selector('div.pagination') }

            it "should list each user" do
              User.paginate(page: 1).each do |user|
                expect(page).to have_selector('li', text: user.username)
              end
            end
          end
        end
      end
    end
  end
end
