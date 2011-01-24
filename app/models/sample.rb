class Sample < ActiveRecord::Base
  belongs_to :sym
  serialize :data
  attr_accessible :data
end
