class CreateMemoRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :memo_rooms do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
