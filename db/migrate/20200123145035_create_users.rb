class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :introduction
      t.string :picture
      t.string :post_a_picture
      t.string :post_b_picture

      t.timestamps
    end
  end
end
