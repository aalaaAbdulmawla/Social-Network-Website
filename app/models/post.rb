class Post < ActiveRecord::Base
  belongs_to :user
  validate :any_present?


  def self.find_posts(user)
  	Post.find_by_sql("SELECT * FROM posts where is_public = 'Public'
                     UNION
                     SELECT * FROM posts where user_id = '#{user.id}'
                     UNION
                     SELECT * FROM posts where user_id IN (
  		                  SELECT id FROM users where id IN ( SELECT to_id FROM friendables WHERE friendables.from_id = #{user.id} AND accepted = 1
  		 									UNION
  		 									SELECT from_id FROM friendables WHERE friendables.to_id = #{user.id} AND accepted = 1) ) 
                     ORDER BY created_at DESC")
  end

  mount_uploader :attachment, AvatarUploader
  acts_as_votable

  private
    def any_present?
      if content.blank? and attachment.blank?
        errors.add :base, "You must fill in at least one field"
      end
    end

end
