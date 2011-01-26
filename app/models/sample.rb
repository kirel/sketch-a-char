class Sample < ActiveRecord::Base
  belongs_to :sym
  belongs_to :submitter, :class_name => "User"
  validates_presence_of :sym, :submitter
  acts_as_voteable
  attr_accessible :data
  serialize :data
  
  # TODO validate data
  
  scope :best_first, order('samples.plusminus_cache DESC')
  
  def update_plusminus_cache
    self.plusminus_cache = self.plusminus
    save(validate: false)
  end
  
  def as_json options = {}
    data
  end
end
