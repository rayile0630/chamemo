class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :memo_room, dependent: :destroy
end
