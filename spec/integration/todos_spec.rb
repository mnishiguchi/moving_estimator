require 'rails_helper'

describe "Todos", type: :feature do

  let(:user) { FactoryGirl.create(:user) }

  before do
    log_in_as(user)
    visit todos_path
  end

  describe "visiting todos page"  do
    it { expect(page).to have_title("Todo") }
    # it { expect(page).to have_content("Add Todo") }
  end

end
