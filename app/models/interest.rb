class Interest < ActiveRecord::Base
  has_many :user_interests, dependent: :destroy
  attr_accessible :name
end
