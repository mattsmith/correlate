class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :twitter

  validates :twitter, presence: true

  has_many :user_interests, dependent: :destroy
  has_many :interests, through: :user_interests
  has_many :related, dependent: :destroy

  def next
    User.where("id > ?", self.id).order(:id).first
  end
end
