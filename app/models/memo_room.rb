class MemoRoom < ApplicationRecord
  belongs_to :user
  belongs_to :category, dependent: :destroy
  
  has_many :memo_room_posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :memo_room_comments, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 20 }
  
  def self.search(search)
      return MemoRoom.all unless search
      MemoRoom.where(['title LIKE ?', "%#{search}%"])
  end
end
