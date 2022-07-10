class FavoritesController < ApplicationController

    def create
      @favorite = Favorite.create(user_id: current_user.id, diary_id: params[:id])
      redirect_to diary_path
    end

    def destroy
      @favorite = Favorite.find_by(user_id: current_user.id, diary_id: params[:id])
      @favorite.destroy
      redirect_to diary_path
    end  

end
