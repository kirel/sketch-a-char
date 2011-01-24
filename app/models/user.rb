class User < ActiveRecord::Base
  has_many :authorizations
  validates_presence_of :name
  
  def self.create_from_hash!(hash)
    create!(:name => hash['user_info']['name'])
  end
end