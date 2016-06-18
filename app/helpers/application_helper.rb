module ApplicationHelper
	def default_img(user)
	  if user.avatar_url.nil?
	  	if (user.gender == "Male")
	   		 "male.PNG"
	    else
	    	"female.PNG"
	    end
	  else
	    user.avatar_url
	  end
	end

	def full_name(user)
		user.first_name + " " + user.last_name
	end
end
