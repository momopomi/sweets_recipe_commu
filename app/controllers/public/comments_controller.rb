class Public::CommentsController < ApplicationController
  before_action :set_recipe
  before_action :authenticate_customer!    # ログイン中のみ許可
  
  def create
    @comment = @recipe.comments.create(comment_params)
    if @comment.save
      redirect_to recipe_path(@recipe), notice: 'コメントしました'
    else
      flash.now[:alert] = 'コメントに失敗しました'
      render recipe_path(@recipe)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to recipes_path(@recipe), notice: 'コメントを削除しました'
    else
      flash.now[:alert] = 'コメント削除に失敗しました'
      render recipes_path(@recipe)
    end
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
  
  def comment_params
    params.required(:comment).permit(:comment).merge(customer_id: current_customer.id, recipe_id: params[:recipe_id])
  end
end
