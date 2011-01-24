class Sym < ActiveRecord::Base
  has_many :samples, dependent: :destroy
  has_friendly_id :name, :use_slug => true
  validates_presence_of :name
  validates_uniqueness_of :name
end
