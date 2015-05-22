class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    # @username = current_user.try(:username)
    # @email = current_user.try(:email)
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      ContactMailer.message_from_user(@contact).deliver_now
      flash[:info] = "Thank you for your message!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  # TODO Write a contacts_controller_test.
end
