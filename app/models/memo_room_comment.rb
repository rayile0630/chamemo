class MemoRoomComment < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :memo_room, dependent: :destroy
  
  validates :content, presence: true, length: { maximum: 50} 
end
