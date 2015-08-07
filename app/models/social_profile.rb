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
    profile.set_oauth_data(auth)
  end

  def set_oauth_data(auth)

    return if provider.to_s != auth['provider'].to_s || uid != auth['uid']

    credentials = auth['credentials']
    info        = auth['info']

    # self.access_token  = credentials['token']
    # self.access_secret = credentials['secret']
    self.credentials   = credentials.to_json
    self.email         = info['email']
    self.name          = info['name']
    self.nickname      = info['nickname']
    self.description   = info['description'].try(:truncate, 255)
    self.image_url     = info['image']

    case provider.to_s
    when 'twitter'
      self.url              = info['urls']['Twitter']
      self.other[:location] = info['location']
      self.other[:website]  = info['urls']['Website']
    end

    self.set_raw_info(auth['extra']['raw_info'])

    self.save!  # Finally save to database here
    self        # Return this profile
  end

  def set_raw_info(raw_info)

    case provider.to_s
    when 'twitter'
      self.other[:followers_count] = raw_info['followers_count']
      self.other[:friends_count]   = raw_info['friends_count']
      self.other[:statuses_count]  = raw_info['statuses_count']
    end
    self.raw_info = raw_info.to_json
  end
end
