forum_1 = Forum.create(title: 'Play Station 5 is out!',
  description: "Just placed my order. Can't wait for it to arrive!")

comment_1 = Comment.create(description: "I want PS5, too!", forum_id: 1)
comment_2 = Comment.create(description: "Second comment that is child of first comment.", forum_id: 1, parent_comment_id: 1)
comment_3 = Comment.create(description: "Third comment that is child of second comment.", forum_id: 1, parent_comment_id: 2)