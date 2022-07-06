class Diary < ApplicationRecord
  validates :title, :content, :date, presence: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :release
  belongs_to :user
end
