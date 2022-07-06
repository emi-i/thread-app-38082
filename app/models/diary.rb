class Diary < ApplicationRecord
  validates :title, :content, :date, presence: true
  belongs_to :user
end
