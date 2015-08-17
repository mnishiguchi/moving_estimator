module SessionsHelper

  def remember_moving(moving)
    session["devise.moving_id"] = moving.id
  end

  def forget_moving
    session.delete("devise.moving_id")
  end

  def current_moving
    session["devise.moving_id"]
  end
end
