class Public::RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
  end
  
  def search
    @recipes = Recipe.where(genre_id: params[:genre_id])
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer = current_customer
    if @recipe.save
      flash.now[:success] = "商品の新規登録が完了しました。"
      redirect_to recipe_path(@recipe.id)
    else
      flash.now[:danger] = "商品の新規登録内容に不備があります。"
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @genres = Genre.all
    
    @comment = Comment.new     # フォーム用のインスタンス作成(コメント追加用)
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def index
      @recipes = Recipe.all
      @genres = Genre.all
      
    if params[:search]
      @searchrequired_time = params[:search].to_i
      @recipes = Recipe.where(required_time: 0..@searchrequired_time)
    end
  end
  

  def update
     @recipe = Recipe.find(params[:id])
     if @recipe.update(recipe_params)
       flash.now[:success] = "商品詳細の変更が完了しました。"
       redirect_to recipe_path(@recipe)
     else
       flash.now[:danger] = "商品詳細の変更内容に不備があります。"
       render :edit
     end
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    flash[:success] = "レシピを削除"
    redirect_back(fallback_location: root_path)
  end

  private
  def recipe_params
    params.require(:recipe).permit(:genre_id, :image, :recipe_name, :required_time, :ingredient, :process,)
  end

end
