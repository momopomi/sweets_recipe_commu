class Public::GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
    @recipes = Recipe.where(genre_id: @genre.id).page(params[:page]).per(8)
    @genres = Genre.all
  end
end
