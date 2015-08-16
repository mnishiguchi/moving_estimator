require 'rails_helper'

feature "Movings form interface", type: :feature do

  let(:user) { FactoryGirl.create(:user) }
  let(:submit) { "Create moving" }

  before(:all) { 16.times { FactoryGirl.create(:room) } }

  before do
    log_in_as user
    visit root_path
    first(:link, "New moving").click
  end

  # Currently validation is removed
  # describe "with invalid information" do
  #   it "should not create a moving" do
  #     expect { click_button submit }.not_to change(Moving, :count)
  #   end

  #   describe "after submission" do
  #     before { click_button submit }
  #     it { expect(page).to have_content('error') }
  #   end
  # end

  describe "with valid information" do
    before do
      find("#moving_title").set("test title")
      find("#moving_description").set(Faker::Hacker.say_something_smart)
      select "international", from: "Moving type"
      find("#moving_move_date").set(Time.zone.now)
      find("#moving_dwelling_sqft").set(999)
      check "room 1"
      check "room 2"
      select "apartment", from: "Dwelling type"
      find("#moving_street_from").set(Faker::Address.street_address)
      find("#moving_city_from").set(Faker::Address.city)
      find("#moving_state_from").set "Tokyo"
      find("#moving_zip_from").set(Faker::Address.zip)
      find("#moving_country_from").set "Japan"
      find("#moving_street_to").set(Faker::Address.street_address)
      find('#moving_city_to').set(Faker::Address.city)
      find("#moving_state_to").set "Seoul"
      find("#moving_zip_to").set(Faker::Address.zip)
      find("#moving_country_to").set "Korea"
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

      it "has correct data saved in database" do
        reloaded = Moving.last.reload
        expect(reloaded.title).to eq "test title"
        expect(reloaded.move_type).to eq "international"
        expect(reloaded.rooms.map(&:name)).to eq ["room 1", "room 2"]
      end
    end
  end
end
