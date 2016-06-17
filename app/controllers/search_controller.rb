class SearchController < ApplicationController
  def index
	  if params[:search]    
	    @users = User.find_by_sql("SELECT * FROM users WHERE first_name LIKE '%#{params[:search]}%' OR last_name LIKE '%#{params[:search]}%'
	    													 OR email = '#{params[:search]}' OR phone_num = '#{params[:search]}' OR
	    													 hometown LIKE '%#{params[:search]}%'")
	    @posts = current_user.posts.where( 'content LIKE ?', "%#{params[:search]}%" )
	  else
	    @users = User.all
	    @posts = current_user.posts
	  end 
  	
  end

end
