class CreateMemoRoomComments < ActiveRecord::Migration[5.2]
  def change
    create_table :memo_room_comments do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :memo_room, foreign_key: true

      t.timestamps
    end
  end
end
