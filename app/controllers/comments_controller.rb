class CommentsController < ApplicationController
  before_filter :user_verif_comment, only: [:edit]

  def user_verif_comment
    @comment = Comment.find(params[:id])
    if @comment.user_id != $user_login.id
      render file: "public/404.html", ststus: 404
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    redirect_to "/posts/" + String($post_master.id)
  end


  def new
    @comment = Comment.new
    @type_master = "Post"
    @id_master = Integer(params[:id])
  end

  def new_comments_to_comment
    @comment = Comment.new
    @type_master = "Comment"
    @id_master = Integer(params[:id])
    render "new"
  end

  def create
    @type_comments = String(params[:type_comments])
    if @type_comments == "Post"
      @master = Post.find(Integer(params[:id_master]))
      @comment = Comment.new(params[:comment])
      $user_login.comments << @comment
      @master.comments << @comment
      @comment.post_id = @master.id
      @comment.save!
      if @comment.errors.empty?
        redirect_to "/posts/" + String($post_master.id)
      else
        render "/comments/new"
      end
    else
      @master = Comment.find(Integer(params[:id_master]))
      @comment_to_c = Comment.create(params[:comment])
      $user_login.comments << @comment_to_c
      @master.comments << @comment_to_c
      @comment_to_c.post_id = @master.post_id
      @comment_to_c.save!
      if @comment_to_c.errors.empty?
        redirect_to "/posts/" + String($post_master.id)
      else
        render "/comments_to_comments/new"
      end
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to "/posts/" + String($post_master.id)
  end
end
