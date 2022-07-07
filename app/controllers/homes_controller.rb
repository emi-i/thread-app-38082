class HomesController < ApplicationController
  def index
    redirect_to diaries_path if user_signed_in?
  end
end
