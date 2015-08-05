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
  store :other
  validates_uniqueness_of :uid, scope: :provider

  def set_values(omniauth)

    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']

    credentials = omniauth['credentials']
    info        = omniauth['info']

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

    self.set_values_by_raw_info(omniauth['extra']['raw_info'])
  end

  def set_values_by_raw_info(raw_info)

    case provider.to_s
    when 'twitter'
      self.other[:followers_count] = raw_info['followers_count']
      self.other[:friends_count]   = raw_info['friends_count']
      self.other[:statuses_count]  = raw_info['statuses_count']
    end

    self.raw_info = raw_info.to_json
    self.save!
    self
  end
end
