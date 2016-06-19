class Post < ActiveRecord::Base
  attr_accessible :title, :body, :user_id

  belongs_to :user    #one user is unique owner
  has_many :comments, as: :commentable, dependent: :destroy #many comments for a post

end
