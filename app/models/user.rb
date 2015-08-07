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

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  def social_profile(provider)
    social_profiles.select{ |sp| sp.provider == provider.to_s }.first
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the profile and user if they exist
    profile = SocialProfile.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the profile being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated profile) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : profile.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(email: email).first if email

      ap "user: nil; email_is_verified: #{email_is_verified}"

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          username: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email:    email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          provider: "See social profiles",
          uid:      "See social profiles",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the profile with the user if needed
    if profile.user != user
      profile.user = user
      profile.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
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

  # Override
  # def password_required?
  #   ap "password_required?: #{super && provider.blank?}"  #<== debugging

  #   # !persisted? || !password.nil? || !password_confirmation.nil?  # super
  #   super && provider.blank?
  # end


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
