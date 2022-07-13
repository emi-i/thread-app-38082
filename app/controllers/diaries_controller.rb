class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_diary, only: [:show, :edit, :update, :destroy]

  def index
    # 公開だけ表示
    @diaries = Diary.where(release_id: 1).includes(:user)
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
    redirect_to diaries_path if @diary.release_id == 2 && @diary.user_id != current_user.id
  end

  def edit
    redirect_to diaries_path unless current_user.id == @diary.user.id
  end

  def update
    if @diary.update(diary_params)
      redirect_to diary_path(@diary.id)
    else
      render :edit
    end
  end

  def destroy
    @diary.destroy if current_user.id == @diary.user.id
    redirect_to diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :date, :content, :release_id).merge(user_id: current_user.id)
  end

  def find_diary
    @diary = Diary.find(params[:id])
  end
end
