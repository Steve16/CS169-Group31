module UsersHelper

     def auth_user
       redirect_to root_path, notice: "Please sign in." unless signed_in?
     end
     
     def get_user_personality_type(facebook_id)
       user = User.find_by_facebook_id(facebook_id)
       if user and user.survey
         user.survey.personality_type
       else
         ""
       end
     end
     
end
