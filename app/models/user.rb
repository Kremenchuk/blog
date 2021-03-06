class User < ActiveRecord::Base
  attr_accessible :name, :avatar, :email, :password, :password_digest

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 35 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 45 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 3 }

  has_many :comments,dependent: :destroy #many comments from one user
  has_many :posts,dependent: :destroy    #many post from one user
end
