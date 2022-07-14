class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:line]
  validates :name, :nickname, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }, on: :create

  has_one :address
  has_many :diaries
  has_many :favorites, dependent: :destroy
  has_many :sns_credentials

  def favorited_by?(diary_id)
    favorites.where(diary_id: diary_id).exists?
  end
end
