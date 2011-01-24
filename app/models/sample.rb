class Sample < ActiveRecord::Base
  belongs_to :sym
  belongs_to :submitter, :class_name => "User"
  validates_presence_of :sym, :submitter
  acts_as_voteable
  attr_accessible :data
  serialize :data
end
