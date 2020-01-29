class AddMemoRoomRefToMemoRoomPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :memo_room_posts, :memo_room, foreign_key: true
  end
end
