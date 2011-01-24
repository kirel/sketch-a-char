class Sample < ActiveRecord::Base
  belongs_to :sym
  serialize :data
end
