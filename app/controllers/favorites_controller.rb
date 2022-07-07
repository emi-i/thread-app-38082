class FavoritesController < ApplicationController
  class LikesController < ApplicationController
    def create
      Favorite.create(user_id: current_user.id, diary_id: params[:id])
      redirect_to diary_path
    end
  end
end
