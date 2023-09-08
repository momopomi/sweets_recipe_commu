class Admin::RecipesController < ApplicationController
 
  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new     # フォーム用のインスタンス作成(コメント追加用)
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def index
    @recipes = Recipe.all
  end

  def update
     @recipe = Recipe.find(params[:id])
     if @recipe.update(recipe_params)
       flash.now[:success] = "商品詳細の変更が完了しました。"
       redirect_to admin_recipe_path(@recipe)
     else
       flash.now[:danger] = "商品詳細の変更内容に不備があります。"
       render :edit
     end
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:success] = "レシピを削除しました"
    redirect_back(fallback_location: root_path)
  end

  private
  def recipe_params
    params.require(:recipe).permit(:image, :recipe_name, :required_time, :ingredient, :process,)
  end

end
