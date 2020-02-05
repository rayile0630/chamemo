class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { maximum: 50 }                  
  validates :introduction, presence: true, length: { maximum: 50 } 
  
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :memo_room_posts
  has_many :memo_rooms
  has_many :categories
  has_many :favorites, dependent: :destroy
  has_many :favposts, through: :favorites, source: :memo_room, dependent: :destroy
  has_many :memo_room_comments
  
  has_secure_password
  
  #画像のアップロードModelの紐付け
  mount_uploader :picture, ImagesUploader
  mount_uploader :post_a_picture, ImagesUploader
  mount_uploader :post_b_picture, ImagesUploader
  
  def follow(other_user)
      unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
      end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def like(memo_room)
     unless self == memo_room
       favorites.find_or_create_by(memo_room_id: memo_room.id)
     end
  end
  
  def unlike(memo_room)
    favorite = favorites.find_by(memo_room_id: memo_room.id)
    favorite.destroy if favorite
  end
  
  def favpost?(memo_room)
    self.favposts.include?(memo_room)
  end
  
  def feed_posts
    Post.where(user_id: self.following_ids + [self.id])
  end
end