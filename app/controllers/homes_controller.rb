class HomesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to  diaries_path
    end
  end
end
