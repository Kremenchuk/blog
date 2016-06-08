class CommentsToCommentsController < ApplicationController
  def edit
    @comment_to_c = Comment.find(params[:id])
  end

  def show
    $master_comment = Comment.find(params[:id])
    redirect_to action: "new"
  end

  def update
    @comment_to_c = Comment.find(params[:id])
    @comment_to_c.update_attributes(params[:comment_to_c])
    redirect_to "/posts/" + String($post_master.id)
  end


  def new
    @comment_to_c = Comment.new
  end

end
