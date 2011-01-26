class Sym < ActiveRecord::Base
  has_many :samples, dependent: :destroy
  has_friendly_id :name, :use_slug => true
  validates_presence_of :name
  validates_uniqueness_of :name  
  
  # top samples
  def sam
    samples.best_first.limit(5)
  end  
end
