require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end

  describe '住所登録' do
    context '住所登録できる場合' do
      it 'カラムが全て揃っている場合は登録できる' do
        expect(@address).to be_valid
      end
    end
    context '住所登録できない場合' do
      it 'post_codeが空だと購入できない' do
        @address.post_code = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeにハイフンがないと購入できない' do
        @address.post_code = '1111111'
        @address.valid?
        expect(@address.errors.full_messages).to include('Post code はハイフンを入れて半角で入力してください')
      end
      it 'post_codeが全角だと購入できない' do
        @address.post_code = '１１１１１１１'
        @address.valid?
        expect(@address.errors.full_messages).to include('Post code はハイフンを入れて半角で入力してください')
      end
      it 'addressが空だと購入できない' do
        @address.address = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Address can't be blank")
      end
      it 'telが空だと購入できない' do
        @address.tel = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Tel can't be blank")
      end
      it 'telが10桁より少ないと購入できない' do
        @address.tel = '1111'
        @address.valid?
        expect(@address.errors.full_messages).to include('Tel は10桁〜11桁の半角文字で入力してください')
      end
      it 'telが11桁より多いと購入できない' do
        @address.tel = '111111111111'
        @address.valid?
        expect(@address.errors.full_messages).to include('Tel は10桁〜11桁の半角文字で入力してください')
      end
      it 'telが全角だと購入できない' do
        @address.tel = '１２３４５６７８９０'
        @address.valid?
        expect(@address.errors.full_messages).to include('Tel は10桁〜11桁の半角文字で入力してください')
      end
      it 'telにハイフンがあると購入できない' do
        @address.tel = '111-1111-1111'
        @address.valid?
        expect(@address.errors.full_messages).to include('Tel は10桁〜11桁の半角文字で入力してください')
      end
      it 'emergency_contact_nameが空だと購入できない' do
        @address.emergency_contact_name = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Emergency contact name can't be blank")
      end
      it 'emergency_contact_telが空だと購入できない' do
        @address.emergency_contact_tel = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Emergency contact tel can't be blank")
      end
      it 'emergency_contact_telが10桁より少ないと購入できない' do
        @address.emergency_contact_tel = '1111'
        @address.valid?
        expect(@address.errors.full_messages).to include('Emergency contact tel は10桁〜11桁の半角文字で入力してください')
      end
      it 'emergency_contact_telが11桁より多いと購入できない' do
        @address.emergency_contact_tel = '111111111111'
        @address.valid?
        expect(@address.errors.full_messages).to include('Emergency contact tel は10桁〜11桁の半角文字で入力してください')
      end
      it 'emergency_contact_telが全角だと購入できない' do
        @address.emergency_contact_tel = '１２３４５６７８９０'
        @address.valid?
        expect(@address.errors.full_messages).to include('Emergency contact tel は10桁〜11桁の半角文字で入力してください')
      end
      it 'emergency_contact_telにハイフンがあると購入できない' do
        @address.emergency_contact_tel = '111-1111-1111'
        @address.valid?
        expect(@address.errors.full_messages).to include('Emergency contact tel は10桁〜11桁の半角文字で入力してください')
      end
    end
  end
end
