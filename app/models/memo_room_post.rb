class MemoRoomPost < ApplicationRecord
  belongs_to :user
  belongs_to :memo_room
  
  validates :content, presence:true, length: { maximum: 255 }
  validates :role, numericality: { only_integer: true}
end
