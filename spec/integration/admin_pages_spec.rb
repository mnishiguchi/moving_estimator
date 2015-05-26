require 'rails_helper'

describe "Admin pages", type: :feature do

  subject { page }

  describe "users#index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      user.update_attribute(:admin, true)
      valid_login user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      # it "should list each user" do
      #   User.paginate(page: 1).each do |user|
      #     expect(page).to have_selector('li', text: user.name)
      #   end
      # end
    end
  end
end
