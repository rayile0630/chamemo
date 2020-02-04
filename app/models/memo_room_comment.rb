class MemoRoomComment < ApplicationRecord
  belongs_to :user
  belongs_to :memo_room
  
  validates :content, presence: true, length: { maximum: 50} 
end
