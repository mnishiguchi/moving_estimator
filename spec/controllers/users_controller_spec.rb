require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  # Index Authorization
  it "should redirect index when not logged in"
  it "should get new"

  # Illegal Access to Admin Attribute
  it "should not allow the admin attribute to be edited via the web"

  # Destroy Authorization
  it "should redirect destroy when not logged in"
  it "should redirect destroy when logged in as a non admin"
end
