class Category < ApplicationRecord
  belongs_to :user
  has_many :memo_rooms, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 20 }
end
