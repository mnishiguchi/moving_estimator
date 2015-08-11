# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  admin                  :boolean          default(FALSE)
#  username               :string
#  corporate              :boolean          default(FALSE)
#  mover_url              :string
#  provider               :string
#  uid                    :string
#  unconfirmed_email      :string
#

class User < ActiveRecord::Base

  attr_accessor :current_moving

  has_many :todos,   dependent: :destroy
  has_many :movings, dependent: :destroy
  has_many :moving_items, through: :movings, dependent: :destroy
  has_many :social_profiles, dependent: :destroy

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  # https://github.com/plataformatec/devise/wiki/How-to:-Use-a-custom-email-validator-with-Devise
  validates :email, :presence => true, :email => true

  # The username attribute was added via application controller.
  # The admin attribute was added by migration.

  scope :sorted, ->{ order(username: :asc) }
  scope :search, ->(q) { where("username ilike ?", "%#{q}%") }

  # ==> currently-selected moving

  def remember_moving(moving)
    current_moving = moving
  end

  def forget_moving
    current_moving = nil
  end

  # ==> OmniAuth

  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end

  # Ensure that user's email is confirmed.
  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  # Undo the effect of skip_confirmation!
  def reset_confirmation!
    self.update_column(:confirmed_at, nil)
  end

  # Override
  # Run User.new based on session["devise.user_attributes"] when it exists.
  # Devise will clean up session with "devise." namespace.
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # ==> current user made available through User model

  # Sets current user in Thread.
  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  # Gets current user from Thread.
  def self.current_user
    Thread.current[:current_user]
  end
end
