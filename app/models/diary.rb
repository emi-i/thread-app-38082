class Diary < ApplicationRecord
  validates :title, :content, :date, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :release
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorites, through: :favorites, source: :user
end
