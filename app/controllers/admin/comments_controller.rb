class Admin::CommentsController < ApplicationController

  before_action :authenticate_admin!    # ログイン中のみ許可

  

  def destroy
    comment = Comment.find(params[:id])
    recipe = comment.recipe
    comment.destroy
    redirect_to admin_recipe_path(recipe)
  end


   private

  def comment_params
    params.require(:comment).permit(:comment, :review)
  end
end