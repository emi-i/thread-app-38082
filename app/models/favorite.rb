class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :diaty
end
