class Related < ActiveRecord::Base
  belongs_to :user
  attr_accessible :count, :paired_id
end
