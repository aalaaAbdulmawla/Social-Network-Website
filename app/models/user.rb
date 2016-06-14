class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, ImageUploader

  #validations
  validates :first_name,:last_name, :email, :gender,  presence: true
  validates :first_name,:last_name, :email, :hometown,  length: { maximum: 100 }
  validates :about , length: {maximum: 500}
  validates :avatar_url, allow_blank: true, format:{
 	with: %r{\.(gif|jpg|png)\Z}i,
 	message: 'must be a URL for GIF, JPG, PNG image.'
  }

  validates :phone_num, allow_blank:true, numericality: { only_integer: true },
                 :length => { :maximum => 15 }


  acts_as_follower
  acts_as_followable

  def self.find_friends (user)
    friends =  Follow.find_by_sql("SELECT * FROM follows, users  WHERE follows.follower_id = #{user.id} AND users.id != #{user.id}  AND follows.blocked = 'f' AND follows.status = 0")+
               Follow.find_by_sql("SELECT * FROM follows, users  WHERE follows.followable_id = #{user.id} AND users.id != #{user.id} AND follows.blocked = 'f' AND follows.status = 0")
    
  end
  

end
