class UsersController < ApplicationController
	# def friend_list
	# 	@frnds =  User.find_friends(current_user)
	# end

	# def friend_requests
	# 	@frnds =  User.find_friend_requests(current_user)
	# end

	def show
 		 @user = User.find(params[:id])
 		 @posts = @user.posts.all.order('created_at DESC')
	end

	# def follow
	#   @user = User.find(params[:id])

	#   if current_user
	#     if current_user == @user
	#       flash[:error] = "You cannot follow yourself."
	#     else
	#       current_user.follow(@user)
	#       #RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
	#       flash[:notice] = "A friend request has been sent to #{@user.first_name}."
	#     end
	#   else
	#     flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.monniker}.".html_safe
	#   end
	#   redirect_to :back
	# end

	# def unfollow
	#   @user = User.find(params[:id])

	#   if current_user
	#     # current_user.stop_following(@user)
	#     User.reject_friend(@user, current_user)
	#     # flash[:notice] = "You are no longer following #{@user.first_name}."
	#   else
	#     flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.first_name}.".html_safe
	#   end
	#   redirect_to :controller => "users", :action => "friend_requests"
	# end

	# def accept_friend
	# 	@user = User.find(params[:user])
	# 	if current_user
	# 	    # current_user.stop_following(@user)
	# 	    User.accept_friend(@user, current_user)
	# 	    flash[:notice] = "You and #{@user.first_name} are now friends."
	#     else
	#     	flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.first_name}.".html_safe
	#   end
	#  	 redirect_to :controller => "users", :action => "friend_requests"
	# end
end
