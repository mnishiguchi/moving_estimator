class RegistrationsController < Devise::RegistrationsController

  protected

  # Override
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-edit-their-account-without-providing-a-password
  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
