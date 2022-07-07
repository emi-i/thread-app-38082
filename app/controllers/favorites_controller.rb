class FavoritesController < ApplicationController

    def create
      Favorite.create(user_id: current_user.id, diary_id: params[:id])
      redirect_to diary_path
    end

    def destroy
      Favorite.find_by(user_id: current_user.id, diray_id: params[:id]).destroy
      redirect_to diary_path
    end  

end
