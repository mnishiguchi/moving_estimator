# RSpec custom matchers

def valid_login(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end
