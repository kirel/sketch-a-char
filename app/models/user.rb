class User < ActiveRecord::Base
  has_many :authorizations, dependent: :destroy
  validates_presence_of :name
  attr_accessible :name
  has_friendly_id :name, :use_slug => true
  acts_as_voter
  has_karma :samples, as: :submitter
  
  def self.create_from_hash!(hash)
    create!(:name => hash['user_info']['name'])
  end
  
  def identity?
    authorizations.any?
  end
  
  def admin?
    superuser? # || Rails.env.development? # TODO allow based on karma!
  end
  
  def update_karma_cache!
    self.karma_cache = self.karma
    save! validate: false
  end
  
  scope :top, order('users.karma_cache DESC')
  
end
