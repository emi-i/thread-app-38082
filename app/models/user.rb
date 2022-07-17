class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]
  validates :name, :nickname, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }, on: :create

  has_one :address, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :sns_credentials, dependent: :destroy

  def self.from_omniauth(auth)
    sns = SnsCredential.first_or_create(provider: auth.provider, uid: auth.uid)
    user = User.first_or_initialize(nickname: auth.info.name)

    if user.persisted?
      sns.user = user
      sns.save
    end
    user
  end

  def favorited_by?(diary_id)
    favorites.where(diary_id: diary_id).exists?
  end
end
