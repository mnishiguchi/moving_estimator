class SessionsController < Devise::SessionsController

  # Overrride
  def new
    unless Rails.env.test?
      redirect_to  root_url
    end
  end

  # Overrride
  def destroy
    super
    session[:keep_signed_out] = true # Set a flag to suppress auto sign in
  end
end

  # # GET /resource/sign_in
  # def new
  #   self.resource = resource_class.new(sign_in_params)
  #   clean_up_passwords(resource)
  #   respond_with(resource, serialize_options(resource))
  # end

  # # DELETE /resource/sign_out
  # def destroy
  #   signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  #   set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
  #   yield if block_given?
  #   respond_to_on_destroy
  # end
