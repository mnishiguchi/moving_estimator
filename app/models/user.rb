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
         :recoverable, :rememberable, :trackable, :validatable

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
