class DiariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @diaries = Diary.where(release_id: 1)
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      redirect_to diaries_path
    else
      render :new
    end
  end

  def show
    @diary = Diary.find(params[:id])
    redirect_to diaries_path if @diary.release_id == 2 && @diary.user_id != current_user.id
  end

  def edit
    @diary = Diary.find(params[:id])
    redirect_to diaries_path if @diary.release_id == 2 && @diary.user_id != current_user.id
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to diary_path(@diary.id)
    else
      render :edit
    end
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy if current_user.id == @diary.user.id
    redirect_to diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :date, :content, :release_id).merge(user_id: current_user.id)
  end
end
