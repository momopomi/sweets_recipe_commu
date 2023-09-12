class Public::RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
  end
  
  def search
    @recipes = Recipe.where(genre_id: params[:genre_id])
    
    if params[:keyword].present?
      @recipes = Recipe.where('caption LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @recipes = Recipe.all
    end
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
    @search = Recipe.ransack(params[:q])
    @recipes = @search.result.page(params[:page]).per(8)
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
    flash[:success] = "選択いただいたカートを空にしました"
    redirect_back(fallback_location: root_path)
  end

  private
  def recipe_params
    params.require(:recipe).permit(:genre_id, :image, :recipe_name, :required_time, :ingredient, :process,)
  end

end
