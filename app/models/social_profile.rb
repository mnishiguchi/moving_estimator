# == Schema Information
#
# Table name: social_profiles
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  provider    :string
#  uid         :string
#  name        :string
#  nickname    :string
#  email       :string
#  url         :string
#  image_url   :string
#  description :string
#  other       :text
#  credentials :text
#  raw_info    :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SocialProfile < ActiveRecord::Base
  belongs_to :user
  store      :other
  validates_uniqueness_of :uid, scope: :provider

  def self.find_for_oauth(auth)
    profile = find_or_create_by(uid: auth.uid, provider: auth.provider)
    profile.save_oauth_data!(auth)
    profile
  end

  def save_oauth_data!(auth)
    return unless valid_oauth?(auth)
    set_credentials(auth['credentials'])
    set_info(auth['info'])
    set_raw_info(auth['extra']['raw_info'])
    save!
  end

  private

    def valid_oauth?(auth)
      (self.provider.to_s == auth['provider'].to_s) && (self.uid == auth['uid'])
    end

    def set_credentials(credentials)
      self.credentials = credentials.to_json
    end

    def set_info(info)
      self.email       = info['email']
      self.name        = info['name']
      self.nickname    = info['nickname']
      self.description = info['description'].try(:truncate, 255)
      self.image_url   = info['image']
      # case provider.to_s
      # when 'twitter'
      #   self.url              = info['urls']['Twitter']
      #   self.other[:location] = info['location']
      #   self.other[:website]  = info['urls']['Website']
      # end
    end

    def set_raw_info(raw_info)
      self.raw_info = raw_info.to_json
      # case provider.to_s
      # when 'twitter'
      #   self.other[:followers_count] = raw_info['followers_count']
      #   self.other[:friends_count]   = raw_info['friends_count']
      #   self.other[:statuses_count]  = raw_info['statuses_count']
      # end
    end
end
