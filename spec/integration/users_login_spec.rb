require 'rails_helper'

describe "Users login", type: :feature do

  subject { page }

  describe "login page" do
    before { visit '/users/sign_in' }

    it { is_expected.to have_content('Log in') }
    it { is_expected.to have_title(full_title('Log in')) }
  end
end
