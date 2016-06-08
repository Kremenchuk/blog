class PostsController < ApplicationController
  before_filter :user_verif_post, only: [:edit]

  def user_verif_post
    @post = Post.find(params[:id])
    if @post.user_id != $user_login.id
      render file: "public/404.html", ststus: 404
    end
  end

  def index
    @posts = Post.all.order("id DESC")
  end

  def show
    @post = Post.find(params[:id])
    $post_master = @post
    @comment = Comment.where(commentable_id: "#{@post.id}", commentable_type: "Post")
    @comment_to_c = Comment.where(post_id: "#{@post.id}",commentable_type: "Comment")
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    if @post.errors.empty?
      redirect_to "/posts"
    else
      render "/posts/edit"
    end
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = $user_login.id
    @post.save!
    if @post.errors.empty?
      redirect_to post_path(@post)
    else
      render "/posts/new"
    end
  end

  def new
    @post = Post.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to action: "index"
  end
end
