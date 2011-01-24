class User < ActiveRecord::Base
  has_many :authorizations, dependent: :destroy
  validates_presence_of :name
  has_friendly_id :name, :use_slug => true
  acts_as_voter
  has_karma :samples, as: :submitter
  
  def self.create_from_hash!(hash)
    create!(:name => hash['user_info']['name'])
  end
end
