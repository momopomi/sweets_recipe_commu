class Admin::CommentsController < ApplicationController
  
  before_action :authenticate_admin!    # ログイン中のみ許可
  
  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_customer.comments.new(comment_params)
    comment.recipe_id = recipe.id
    
    comment.save
    redirect_to recipe_path(recipe)
  end

  def destroy
    comment = Comment.find(params[:id])
    recipe = comment.recipe
    comment.destroy
    redirect_to recipe_path(recipe)
  end


   private

  def comment_params
    params.require(:comment).permit(:comment, :review)
  end
end