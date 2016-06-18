class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, ImageUploader
  after_save :edit_pic_post, if: :avatar_changed?

  #validations
  validates :first_name,:last_name, :email, :gender, :birthdate,  presence: true
  validates :first_name,:last_name, :email, :hometown,  length: { maximum: 100 }
  validates :about , length: {maximum: 500}
  validates :avatar_url, allow_blank: true, format:{
 	with: %r{\.(gif|jpg|png)\Z}i,
 	message: 'must be a URL for GIF, JPG, PNG image.'
  }

  validates :phone_num, allow_blank:true, numericality: { only_integer: true },
                 :length => { :maximum => 15 }

  has_many :friendables
  has_many :users, through: :friendables
  has_many :posts
  
  acts_as_voter
  after_create :set_default_url!
  # around_update :set_default_url!

  def set_default_url!
    url = ImageUploader.default_url(gender)
    update!(avatar: url)
    # User.find_by_sql("UPDATE users SET avatar = #{url.to_s} WHERE user.id = id")
  end

  def self.is_friend(user_1, user_2)
      friends = Friendable.find_by_sql("SELECT * FROM users where id IN ( SELECT to_id FROM friendables WHERE friendables.from_id = #{user_1.id} AND friendables.to_id =#{user_2.id}  AND accepted = 1 )")+
               Friendable.find_by_sql("SELECT * FROM users where id IN ( SELECT from_id FROM friendables WHERE friendables.from_id = #{user_2.id} AND friendables.to_id = #{user_1.id} AND accepted = 1 )")
     (friends.count == 0)? false : true
  end

  def self.has_sent_request(user_1, user_2)
      friends =  Friendable.find_by_sql("SELECT * FROM users where id IN ( SELECT to_id FROM friendables WHERE friendables.from_id = #{user_1.id} AND friendables.to_id = #{user_2.id} AND accepted = 0 )")
      puts("\n\n count = #{friends.count} \n\n")
      (friends.count == 0)? false : true

  end

  # def self.find_friends (user)
  #   friends =  Follow.find_by_sql("SELECT * FROM follows, users  WHERE follows.follower_id = #{user.id} AND users.id != #{user.id}  AND follows.blocked = 'f' AND follows.status = 1")+
  #              Follow.find_by_sql("SELECT * FROM follows, users  WHERE follows.followable_id = #{user.id} AND users.id != #{user.id} AND follows.blocked = 'f' AND follows.status = 1")
    
  # end

  # def self.find_friend_requests(user)
  #   Follow.find_by_sql("SELECT * FROM follows, users  WHERE follows.followable_id = #{user.id} AND users.id != #{user.id} AND follows.blocked = 'f' AND follows.status = 0")
  # end

  # def self.count_friend_requests(user)
  #     find_friend_requests(user).count
  # end

  # def self.reject_friend(sender, recevier)
  #   Follow.destroy_all(:follower_id => sender.id, :followable_id => recevier.id)
  # end

  # def self.accept_friend(sender, recevier)
  #   Follow.find_by_sql("UPDATE follows SET status = 1 WHERE follower_id = #{sender.id} AND followable_id = #{recevier.id}")
 # end

 private

    def edit_pic_post
      if self.avatar_url
        Post.new(:attachment => Pathname.new(self.avatar.path).open,
                 :content => "User #{self.first_name} changed their profile picture",
                 :is_public => 'Private',
                 :user_id => self.id ).save
      end
    end
  

end
