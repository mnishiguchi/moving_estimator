require 'rails_helper'

feature "Moving records interface", type: :feature do

  let(:user) { create(:user) }

  before do
    log_in_as user
    visit root_path
  end

  describe "visit my movings page" do
    before { visit root_path }

    it { expect(page).to have_title(full_title("My movings")) }

    it "has the username" do
      expect(page).to have_content(user.username)
    end

    it "has the user's email address" do
      expect(page).to have_content(user.email)
    end

    # it "has tabs and tab contents" do
    #   expect(page).to have_selector('ul.nav.nav-tabs')
    #   expect(page).to have_selector('div.tab-content')
    # end

    it { expect(page).to have_selector('table') }

    describe "clicking on the link to the new moving page" do
      before { first(:link, "New moving").click  }
      it { expect(page).to have_title(full_title("New moving")) }
    end
  end

  describe "visit a moving page", js: true, driver: :poltergeist do

    let!(:moving) do
      moving = user.movings.create(attributes_for(:moving))
      5.times { moving.moving_items.create(attributes_for(:moving_item)) }
      moving
    end

    before do
      visit moving_path(moving)
    end

    it "has a correct page title" do
      expect(page).to have_content(moving.title)
    end

    it "has a correct header" do
      expect(page).to have_content(moving.description)
      expect(page).to have_title(full_title(moving.title))
    end

    describe "charts panel" do

      it "has 2 charts" do
        expect(page).to have_selector('canvas', count: 2) # two charts
      end

      it "has a total volume" do
        items = moving.moving_items
        subtotals = items.map { |item| item.volume * item.quantity }
        total_volume = subtotals.inject(&:+).to_i
        expect(page).to have_content(total_volume)
      end
    end

    describe "table" do
      it "has a table" do
        expect(page).to have_selector('table')
      end
      it "has correct number of rows" do
        expect(page).to have_selector('tr', count: moving.moving_items.count + 1)
      end
    end
  end
end
