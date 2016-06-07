class Comment < ActiveRecord::Base
  attr_accessible :body, :user_id, :commentable_id, :commentable_type


  belongs_to :user   #one user is unique owner
  #belongs_to :post   #one post is unique owner


  has_many :comments, as: :commentable
  belongs_to :commentable, polymorphic: true
end
