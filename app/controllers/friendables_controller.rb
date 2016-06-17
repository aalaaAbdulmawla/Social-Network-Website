class FriendablesController < ApplicationController
  # before_action :set_friendable, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def friend_requests
    @frnds =  Friendable.find_friend_requests(current_user)
  end

  def friend_list
    @frnds =  Friendable.find_friends(current_user)
  end

  def friend_request
    from_id = current_user.id
    to_id = params[:id] # this is the id of the user you want to become friend with
    friendable = Friendable.create(from_id: from_id, to_id: to_id, accepted: 0)
    redirect_to  :controller => "users", :action => "show", :id => params[:id]
  end
  
  def friend_request_accept
    # accepting a friend request is done by the recipient of the friend request.
    # thus the current user is identified by to_id.

    friendable = Friendable.where(to_id: current_user.id, from_id: params[:id]).first
    friendable.update_attributes(accepted: 1)
    redirect_to :controller => "users", :action => "show", :id => params[:id]
  end

  def friend_request_reject
    friendable = Friendable.where(to_id: current_user.id, from_id: params[:id]).first
    (friendable.nil? ) ? puts('nil') : friendable.destroy
    redirect_to :controller => "users", :action => "show", :id => params[:id]
  end

  def unfriend
    if current_user
      friendable = Friendable.where(to_id: current_user.id, from_id: params[:id]).first
      friendable.destroy if friendable
      friendable = Friendable.where(to_id: params[:id], from_id: current_user).first
      friendable.destroy if friendable
    else
      flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.first_name}.".html_safe
    end
    redirect_to :controller => "users", :action => "show", :id => params[:id]
  end


  # def index
  #   @friendables = Friendable.all
  #   respond_with(@friendables)
  # end

  # def show
  #   respond_with(@friendable)
  # end

  # def new
  #   @friendable = Friendable.new
  #   respond_with(@friendable)
  # end

  # def edit
  # end

  # def create
  #   @friendable = Friendable.new(friendable_params)
  #   @friendable.save
  #   respond_with(@friendable)
  # end

  # def update
  #   @friendable.update(friendable_params)
  #   respond_with(@friendable)
  # end

  # def destroy
  #   @friendable.destroy
  #   respond_with(@friendable)
  # end

  # private
  #   def set_friendable
  #     @friendable = Friendable.find(params[:id])
  #   end

  #   def friendable_params
  #     params.require(:friendable).permit(:from_id, :to_id, :accepted)
  #   end
end
