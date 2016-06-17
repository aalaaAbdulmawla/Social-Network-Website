class Post < ActiveRecord::Base
  belongs_to :user

  def self.find_posts(user)
  	posts = user.posts.all + Post.find_by_sql("SELECT * FROM posts where is_public = 'Public'") + 
  	Post.find_by_sql("SELECT * FROM posts where user_id IN (
  		 SELECT id FROM users where id IN ( SELECT to_id FROM friendables WHERE friendables.from_id = #{user.id} AND accepted = 1
  		 									UNION
  		 									SELECT from_id FROM friendables WHERE friendables.to_id = #{user.id} AND accepted = 1) )")
  	posts.uniq
  end

  mount_uploader :attachment, AvatarUploader

end
