class Friendable < ActiveRecord::Base
  def self.find_friends (user)
   Friendable.find_by_sql("SELECT * FROM users where id IN ( SELECT to_id FROM friendables WHERE friendables.from_id = #{user.id} AND accepted = 1 )")+
               Friendable.find_by_sql("SELECT * FROM users where id IN ( SELECT from_id FROM friendables WHERE friendables.to_id = #{user.id} AND accepted = 1 )")
    
  end

  def self.find_friend_requests(user)
     Friendable.find_by_sql("SELECT * FROM users where id IN ( SELECT from_id FROM friendables WHERE friendables.to_id = #{user.id} AND accepted = 0 )  ")
            
  end

  def self.count_friend_requests(user)
      find_friend_requests(user).count
  end
end
