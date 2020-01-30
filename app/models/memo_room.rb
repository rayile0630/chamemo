class MemoRoom < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  has_many :memo_room_posts
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 20 }
end
