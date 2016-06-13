class UsersController < ApplicationController
	def friends
		
	end

	def friends_requests
		
	end

	def show
 		 @user = User.find(params[:id])
	end

	def follow
	  @user = User.find(params[:id])

	  if current_user
	    if current_user == @user
	      flash[:error] = "You cannot follow yourself."
	    else
	      current_user.follow(@user)
	      #RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
	      flash[:notice] = "A friend request has been sent to #{@user.first_name}."
	    end
	  else
	    flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.monniker}.".html_safe
	  end
	  redirect_to :back
	end

	def unfollow
	  @user = User.find(params[:id])

	  if current_user
	    current_user.stop_following(@user)
	    flash[:notice] = "You are no longer following #{@user.first_name}."
	  else
	    flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.first_name}.".html_safe
	  end
	  redirect_to :back
	end
end
