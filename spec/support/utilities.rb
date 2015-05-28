# RSpec custom matchers

# options: { no_capybara: true|false }
def log_in_as(user, options={})
  # For controller specs
  if options[:no_capybara]
    role = if user.admin? then :admin else :user end
    @request.env["devise.mapping"] = Devise.mappings[role]
    sign_in user
  # For integration specs
  else
    visit new_user_session_path
    fill_in "Email",    with: user.email.upcase
    fill_in "Password", with: user.password
    click_button "Log in"
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end

RSpec::Matchers.define :have_info_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-info', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :send_email_by_click do
  match do |page|
    # To prevent code from breaking in case any other tests deliver email.
    ActionMailer::Base.deliveries.clear
    expect { click_button submit }.to change(ActionMailer::Base.deliveries, :count).by(1)
  end
end
