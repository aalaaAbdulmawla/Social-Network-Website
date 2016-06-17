class HomeController < ApplicationController
  def front
  	if (current_user)
 		@posts = Post.find_posts(current_user)
 	end
  end
end
