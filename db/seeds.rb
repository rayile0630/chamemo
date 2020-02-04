User.create!(name: 'テスト１', email: 'test1@test.com', password: 'test1234', introduction: 'よろしくお願いします')
User.create!(name: 'テスト２', email: 'test2@test.com', password: 'test1234', introduction: 'よろしくお願いします')
User.create!(name: 'テスト３', email: 'test3@test.com', password: 'test1234', introduction: 'よろしくお願いします')
User.create!(name: 'テスト４', email: 'test4@test.com', password: 'test1234', introduction: 'よろしくお願いします')
User.create!(name: 'テスト５', email: 'test5@test.com', password: 'test1234', introduction: 'よろしくお願いします')
User.create!(name: 'テスト６', email: 'test6@test.com', password: 'test1234', introduction: 'よろしくお願いします')

user1 = User.first
user6 = User.last

category = user1.categories.build(title: 'test1')
category1 = user1.categories.build(title: 'test2')
category2 = user1.categories.build(title: 'test3')
category3 = user6.categories.build(title: 'test4')
category4 = user6.categories.build(title: 'test5')
category5 = user6.categories.build(title: 'test6')

category.save!
category1.save!
category2.save!
category3.save!
category4.save!
category5.save!

category = Category.first
category1 = Category.last
@memo_room = user1.memo_rooms.build(title: 'テスト', category_id: category.id)
@memo_room1 = user1.memo_rooms.build(title: 'テスト1', category_id: category.id)
@memo_room2 = user1.memo_rooms.build(title: 'テスト2', category_id: category.id)

@memo_room3 = user1.memo_rooms.build(title: 'メモルーム1', category_id: category1.id)
@memo_room4 = user1.memo_rooms.build(title: 'メモルーム２', category_id: category1.id)
@memo_room5 = user1.memo_rooms.build(title: 'メモルーム３', category_id: category1.id)

@memo_room.save!
@memo_room1.save!
@memo_room2.save!
@memo_room3.save!
@memo_room4.save!
@memo_room5.save!

@memo_room = MemoRoom.first
@memo_room1 = MemoRoom.last
current_user = User.first
current_user1 = User.last 

@memo_room_post = current_user.memo_room_posts.build(content: 'テスト発言1', memo_room_id: @memo_room.id, role: 0)
@memo_room_post1 = current_user.memo_room_posts.build(content: 'テスト発言2', memo_room_id: @memo_room.id, role: 1)
@memo_room_post2 = current_user.memo_room_posts.build(content: 'テスト発言3', memo_room_id: @memo_room.id, role: 0)
@memo_room_post3 = current_user.memo_room_posts.build(content: 'テスト発言4', memo_room_id: @memo_room.id, role: 1)

@memo_room_post4 = current_user1.memo_room_posts.build(content: 'テスト発言1', memo_room_id: @memo_room1.id, role: 0)
@memo_room_post5 = current_user1.memo_room_posts.build(content: 'テスト発言2', memo_room_id: @memo_room1.id, role: 1)
@memo_room_post6 = current_user1.memo_room_posts.build(content: 'テスト発言3', memo_room_id: @memo_room1.id, role: 0)
@memo_room_post7 = current_user1.memo_room_posts.build(content: 'テスト発言4', memo_room_id: @memo_room1.id, role: 1)

@memo_room_post.save!
@memo_room_post1.save!
@memo_room_post2.save!
@memo_room_post3.save!
@memo_room_post4.save!
@memo_room_post5.save!
@memo_room_post6.save!
@memo_room_post7.save!
