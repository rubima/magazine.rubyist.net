# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(*policy(@post || Post).permitted_attributes)
  end
end
