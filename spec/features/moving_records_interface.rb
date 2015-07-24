require 'rails_helper'

feature "Moving records interface", type: :feature do

  let(:user) { FactoryGirl.create(:user) }

  before do
    log_in_as user
  end

  describe "visit my moving page" do
    before { visit root_path }

    it { expect(page).to have_title(full_title("My movings")) }

    it "has the user's email address" do
      expect(page).to have_content(user.email)
    end

    it "has tabs and tab contents" do
      expect(page).to have_selector('ul.nav.nav-tabs')
      expect(page).to have_selector('div.tab-content')
    end

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

  describe "visit a moving page", js: true, driver: :poltergeist do
    let(:moving) do
      moving = user.movings.create(FactoryGirl.attributes_for(:moving))
        5.times do
          moving.moving_items.create(FactoryGirl.attributes_for(:moving_item))
        end
      moving
    end

    before { visit moving_path(moving) }

    it "has a correct page title" do
      expect(page).to have_content(moving.title)
    end

    it "has a correct header" do
      expect(page).to have_content(moving.description)
      expect(page).to have_title(full_title(moving.title))
    end

    it "has a moving records component" do
      expect(page).to have_selector('canvas', count: 2) # two charts
      expect(page).to have_selector('ul.nav.nav-tabs')  # tabs
      expect(page).to have_selector('div.tab-content')  # tab contents
      expect(page).to have_selector('table')
    end

    describe "moving records component" do

      describe "charts panel" do

        it "has a total volume" do
          items = moving.moving_items
          subtotals = items.map { |item| item.volume * item.quantity }
          total_volume = subtotals.inject(&:+).to_i
          expect(page).to have_content(total_volume)
        end
      end

      describe "tabs" do

        it { expect(page).to have_selector('table') }
        it { expect(page).to have_selector('tr', count: moving.moving_items.count + 1) }

        describe "the second tab" do
          before { click_link "Add new item" }

          it "has a form" do
            expect(page).to have_content("Add a new item")
            expect(page).to have_selector('form')
          end

          describe "form" do
            let(:submit) { "Add item" }

            describe "with invalid information" do
              it { expect(page).to have_button(submit, disabled: true) }
            end

            describe "with valid information" do
              let(:item_name) { Faker::Commerce.product_name.upcase! }

              it "create a new item and insert it into the table" do
                fill_in "name",     with: item_name
                fill_in "volume",   with: "3"
                fill_in "quantity", with: "1"
                fill_in "category", with: "local"
                fill_in "room",     with: "living room"
                click_button submit
                expect(page).to have_content(item_name.downcase!)
                expect(MovingItem.last.name).to eq item_name
              end
            end
          end
        end

        describe "the first tab" do
          before { click_link "All items" }

          it "has a table" do
            expect(page).to have_content("All items")
            expect(page).to have_selector('table')
          end

          describe "table" do

            describe "normal mode" do
              it "has edit and delete buttons in each row" do
                count = moving.moving_items.count
                expect(page).to have_selector('button.edit', count: count)
                expect(page).to have_selector('button.delete', count: count)
              end
            end

            describe "delete mode" do
              it "deletes an item when clicking the delete button" do
                expect{
                  first("button.delete").click
                  sleep 0.5
                }.to change(MovingItem, :count).by(-1)
              end
            end

            describe "edit mode" do
              before { first("button.edit").click }

              it "has update and undo buttons after clicking the edit button" do
                expect(page).to have_selector('button.update', count: 1)
                expect(page).to have_selector('button.undo', count: 1)
              end

              describe "with invalid information" do
                it "does not update an item" do
                  find("textarea.name").set("")
                  find('button.update').click
                  sleep 0.5
                  expect(page).to have_content("can't be blank")
                end
              end

              describe "with valid information" do
                let(:item_name) { Faker::Commerce.product_name.upcase! }

                it "updates an item" do
                  find("textarea.name").set(item_name)
                  find('button.update').click
                  sleep 0.5
                  expect(page).to have_selector("td", text: item_name.downcase!)
                  expect(page).to have_content("Record updated")
                end
              end

              describe "undo" do
                let(:item_name) { Faker::Commerce.product_name.upcase! }

                it "goes back to normal mode" do
                  find("textarea.name").set(item_name)
                  find('button.undo').click
                  expect(page).not_to have_selector("td", text: item_name.downcase!)
                  expect(page).to have_selector("button.edit")
                  expect(page).to have_selector("button.delete")
                end
              end
            end
          end
        end
      end
    end
  end
end
