class Related < ActiveRecord::Base
  belongs_to :user
  belongs_to :paired, :class_name => 'User'
  attr_accessible :count, :paired, :correlation

  scope :sorted, order(:correlation)
end
