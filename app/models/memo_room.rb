class MemoRoom < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  has_many :memo_room_posts
  
  validates :title, presence: true, length: { maximum: 20 }
end
