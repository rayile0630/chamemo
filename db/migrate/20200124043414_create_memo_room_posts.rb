class CreateMemoRoomPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :memo_room_posts do |t|
      t.string :content
      t.integer :role, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
