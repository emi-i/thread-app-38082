require 'rails_helper'

RSpec.describe Diary, type: :model do
  before do
    @diary = FactoryBot.build(:diary)
  end

  describe '日記登録' do
    context '日記が登録できる場合' do
      it 'カラムが全て揃っている場合は登録できる' do
        expect(@diary).to be_valid
      end
    end
    context '日記が登録できない場合' do
      it 'titleが空だと登録できない' do
        @diary.title = ''
        @diary.valid?
        expect(@diary.errors.full_messages).to include("Title can't be blank")
      end
      it 'contentが空だと登録できない' do
        @diary.content = ''
        @diary.valid?
        expect(@diary.errors.full_messages).to include("Content can't be blank")
      end
      it 'dateが空だと登録できない' do
        @diary.date = ''
        @diary.valid?
        expect(@diary.errors.full_messages).to include("Date can't be blank")
      end
      it 'userが紐づいてないと登録できない' do
        @diary.user = nil
        @diary.valid?
        expect(@diary.errors.full_messages).to include("User must exist")
      end
    end
  end
end
