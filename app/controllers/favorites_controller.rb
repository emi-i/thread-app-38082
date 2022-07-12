class FavoritesController < ApplicationController
  def create
    @diary = Diary.find(params[:id])
    @favorite = Favorite.create(user_id: current_user.id, diary_id: params[:id])
  end

  def destroy
    @diary = Diary.find(params[:id])
    @favorite = Favorite.find_by(user_id: current_user.id, diary_id: params[:id])
    @favorite.destroy
  end
end
