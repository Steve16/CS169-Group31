class Authorization < ActiveRecord::Base 
  
  def self.find_or_create(auth_hash)
    o_user = User.find_by_email(auth_hash["info"]["email"].downcase)
    unless o_user.present?
      o_user = self.create_social_user(auth_hash["info"], auth_hash['credentials'], auth_hash["uid"])
    else
      #sign_in_user o_user
      o_user = User.find(o_user.id)  
    end
    o_user
  end
  
  def self.create_social_user(auth_hash, credentials, uid)
    #user
    new_pass = SecureRandom.hex(5)
    o_user = User.create(:email => auth_hash["email"],
                      :first_name => auth_hash["first_name"],
                      :last_name => auth_hash["last_name"],
                      :facebook_id => auth_hash["uid"],
                      :password => new_pass,
                      :password_confirmation => new_pass)
                      
    o_user.save(:validate => false)
                 
    return o_user
  end
 
end
