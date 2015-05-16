class Contact
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :email, :message

  validates :first_name, presence: true
  validates :last_name,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,   presence: true,
                      length:   { maximum: 255 },
                      format:   { with: VALID_EMAIL_REGEX }
  validates :message, presence: true,
                      length:   { maximum: 255 }
end
