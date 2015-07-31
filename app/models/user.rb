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
  include PgSearch

  attr_accessor :current_moving

  has_many :todos,   dependent: :destroy
  has_many :movings, dependent: :destroy
  has_many :moving_items, through: :movings, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # The username attribute was added via application controller.
  # The admin attribute was added by migration.

  scope :sorted, ->{ order(username: :asc) }

  pg_search_scope :search,
                  against: [
                    :username,
                    :email
                  ],
                  using: {
                    tsearch: {
                      prefix: true,
                      normalization: 2
                    }
                  }

  def remember_moving(moving)
    current_moving = moving
  end

  def forget_moving
    current_moving = nil
  end

  # ==> OmniAuth

  # Find the user by data from OmniAuth; if not found, create a new user based on that data.
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.username = auth.info.nickname
      user.password = Devise.friendly_token[0,20]
    end
  end

  # Override to be able to accept session["devise.user_attributes"] when it exists.
  # Devise will clean up session with "devise." namespace.
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      # No need for mass assignment protecton since we trust this hash.
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        # Ensure that this user passed all the validations.
        user.valid?
      end
    else
      super
    end
  end

  # Override to check if user's provider attributes is empty.
  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end


  class << self

    # For exporting csv
    def to_csv(options = {})  # e.g., headers
      attributes = %w(id username sign_in_count created_at confirmed_at updated_at)

      CSV.generate(options) do |csv|
        csv << attributes

        all.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
    end

    # Sets current user in Thread.
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    # Gets current user from Thread.
    def current_user
      Thread.current[:current_user]
    end
  end
end
