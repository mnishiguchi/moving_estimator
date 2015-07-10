class StaticPagesController < ApplicationController

  def home
    redirect_to movings_url if current_user
  end
end
