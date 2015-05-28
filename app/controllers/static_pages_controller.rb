class StaticPagesController < ApplicationController

  def home
    redirect_to dashboard_path if user_signed_in?
  end

  def about
  end
end
