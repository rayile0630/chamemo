class MemoRoomPost < ApplicationRecord
  belongs_to :user
  belongs_to :memo_room, dependent: :destroy
  
  validates :content, presence:true, length: { maximum: 200 }
  validates :role, presence:true, numericality: { only_integer: true}
end
