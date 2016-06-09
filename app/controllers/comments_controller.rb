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
  end

  def create
    @type_comments = String(params[:type_comments])
    if @type_comments == "Post"
      @comment = Comment.new(params[:comment])
      $user_login.comments << @comment
      $post_master.comments << @comment
      @comment.save!
      if @comment.errors.empty?
        redirect_to "/posts/" + String($post_master.id)
      else
        render "/comments/new"
      end
    else
      @comment_to_c = Comment.create(params[:comment])
      $user_login.comments << @comment_to_c
      $master_comment.comments << @comment_to_c
      @comment_to_c.post_id = $post_master.id
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
    @comments_slave = Comment.where(commentable_id: "#{@comment.id}",commentable_type: "Comment")
    @comments_slave.each do |i|
      @comments_slave.destroy(i.id)
    end
    @comment.destroy
    redirect_to "/posts/" + String($post_master.id)
  end
end
