class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :address, :emergency_contact_name, presence: true
  validates :post_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンを入れて半角で入力してください' }
  validates :tel, :emergency_contact_tel, presence: true, format: { with: /\A\d{10,11}\z/, message: 'は10桁〜11桁の半角文字で入力してください' }
end
