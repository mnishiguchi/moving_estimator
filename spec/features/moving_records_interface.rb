require 'rails_helper'

describe "Moving records interface", type: :feature do

  let(:user) { FactoryGirl.create(:user) }

  before do
    log_in_as user
  end

  describe "visit my moving page" do
    before { visit root_path }
    it { expect(page).to have_content(user.email) }
    it { expect(page).to have_title(full_title("My movings")) }
    it { expect(page).to have_selector('ul.nav.nav-tabs') }
    it { expect(page).to have_selector('div.tab-content') }
    it { expect(page).to have_selector('table') }

    describe "a new moving form" do
      before { click_link "New moving" }
      let(:submit) { "Create moving" }
      it { expect(page).to have_title(full_title("New moving")) }

      describe "with invalid information" do
        it "should not create a moving" do
          expect { click_button submit }.not_to change(Moving, :count)
        end
        describe "after submission" do
          before { click_button submit }
          it { expect(page).to have_content('error') }
        end
      end

      describe "with valid information" do
        before do
          fill_in "Title",       with: "Moving to DC"
          fill_in "Description", with: "Exciting!!!"
        end

        it "should create a moving" do
          expect { click_button submit }.to change(Moving, :count).by(1)
        end

        describe "after saving the moving" do
          before { click_button submit }
          let(:moving) { user.movings.first }
          it "redirects to the new moving's show page" do
            expect(page).to have_title(full_title(moving.title))
            expect(page).to have_success_message('Moving created')
            expect(page).to have_content(moving.title)
            expect(page).to have_content(moving.description)
          end
        end
      end
    end
  end

  describe "visit a moving page", js: true do
    let(:moving) do
      moving = user.movings.create(FactoryGirl.attributes_for(:moving))
        5.times do
          moving.moving_items.create(FactoryGirl.attributes_for(:moving_item))
        end
      moving
    end
    after(:all) { MovingItem.delete_all }

    before { visit moving_path(moving) }

    it "has a correct page title" do
      expect(page).to have_content(moving.title)
    end

    it "has a correct header" do
      expect(page).to have_content(moving.description)
      expect(page).to have_title(full_title(moving.title))
    end

    it "has moving records component" do
      expect(page).to have_selector('canvas', count: 2)
      expect(page).to have_selector('ul.nav.nav-tabs')
      expect(page).to have_selector('div.tab-content')
      expect(page).to have_selector('table')
    end

    describe "moving records component" do
      describe "charts panel" do
        it "has total volume"
        it "has a bar chart"
        it "has a pie chart"
      end

      describe "tabs" do
        describe "moving records table" do
          it "has a table"
        end

        describe "new record form" do
          it "has a form"
        end
      end
    end
  end
end