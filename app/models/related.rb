class Related < ActiveRecord::Base
  belongs_to :user
  belongs_to :paired, :class_name => 'User'
  attr_accessible :count, :paired, :correlation

  scope :sorted, order("correlation DESC")

  def self.correlate
    self.destroy_all
    User.all.each do |user1|

      User.all.each do |user2|
        unless user2 == user1
          # Get the intersection (similar) and union (total) of the users interests
          similar_interests = user1.interests.map(&:id) & user2.interests.map(&:id)
          total_interests = user1.interests.map(&:id) | user2.interests.map(&:id)

          # Calulate the correlation
          jaccard_correlation = (similar_interests.count.to_f/total_interests.count.to_f).round(3)

          # Store the results for each user
          user1.related.create(count: similar_interests.count, correlation: jaccard_correlation, paired: user2)
        end
      end

    end
  end
end
