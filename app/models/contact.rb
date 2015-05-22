class Contact
  include ActiveModel::Model

  attr_accessor :username, :email, :message

  validates :username, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,   presence: true,
                      length:   { maximum: 255 },
                      format:   { with: VALID_EMAIL_REGEX }
  validates :message, presence: true,
                      length:   { maximum: 255 }
end
