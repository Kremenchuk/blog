module PostsHelper
  def posts_comments_user(comment)
    @user = User.find(comment.user_id)
  end
end
