module MovingsHelper

  def remember_moving(moving)
    session[:moving_id] = moving.id
  end

  def forget_moving
    session.delete(:moving_id)
  end

  def current_moving
    session[:moving_id]
  end
end
