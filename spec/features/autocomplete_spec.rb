require 'rails_helper'

feature "Autocomplete interface", type: :feature, js: true, driver: :poltergeist do

  let(:user) { create(:user) }

  before do
    log_in_as user
  end

  describe "movings/new" do

    before do
      visit root_path
      first(:link, "New moving").click
      select "United States", from: "moving_country_to"
    end

    it "has US states suggestion data" do
      expect(page).to have_css("div#moving_suggestions")
      expect(page.find('div#moving_suggestions')["data-us-states"]).to have_content("Alabama")
    end

    it "shows autocomplete with a collect suggestion" do
      fill_autocomplete("moving_state_to", with: "New")
      expect(page).to have_content("New Mexico")
      expect(page).to have_content("New York")
      expect(page).not_to have_content("Alabama")
    end
  end

  describe "movings/edit" do

    let!(:moving) { user.movings.create(attributes_for(:moving)) }

    before do
      visit root_path
      click_link moving.title  # first moving item on the table
      click_link "Edit"        # edit button
      select "United States", from: "moving_country_to"
    end

    it "has US states suggestion data" do
      expect(page).to have_css("div#moving_suggestions")
      expect(page.find('div#moving_suggestions')["data-us-states"]).to have_content("Alabama")
    end

    it "shows autocomplete with a correct suggestion" do
      fill_autocomplete("moving_state_to", with: "New")
      expect(page).to have_content("New Mexico")
      expect(page).to have_content("New York")
      expect(page).not_to have_content("Alabama")
    end
  end

  describe "moving_items/new" do

    let!(:moving_item) do
      moving = user.movings.create(attributes_for(:moving))
      moving.moving_items.create(attributes_for(:moving_item))
    end

    before(:each) do
      visit root_path
      click_link user.movings.first.title  # first moving item on the table
      find("a", text: /new item/i).click
    end

    it "has household goods suggestion data" do
      expect(page).to have_css("div#suggestions")
      # expect(page.find('div#suggestions')["data-items"].keys).to include("desk")
    end

    it "shows autocomplete with a correct suggestion"
    # it "shows autocomplete with a correct suggestion" do
    #   fill_autocomplete("moving_item_name", with: "pi")
    #   expect(page).to have_content("upright piano")
    #   expect(page).to have_content("grand piano")
    #   expect(page).not_to have_content("pictures")
    # end
  end

end

def fill_autocomplete(field, options = {})
  fill_in field, with: options[:with]

  page.execute_script %Q{ $('##{field}').trigger('focus') }
  page.execute_script %Q{ $('##{field}').trigger('keydown') }

  selector = %Q{ ul.ui-autocomplete li.ui-menu-item a:contains("#{options[:select]}") }

  expect(page).to have_selector('ul.ui-autocomplete')
  page.execute_script %Q{ $('#{selector}').trigger('mouseenter').click() }
end
