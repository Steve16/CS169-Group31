class UsersController < ApplicationController

  before_filter :auth_user, only: [:show]

  def new
    @sign_up = true
    @user = User.new
  end

  def show
    @user = current_user
    if !@user.has_completed_survey?
      redirect_to :survey
    else 
    @personality_db = Profile.find_by_personality_type(@user.survey.personality_type)
    #puts @personality_db.inspect

    @video_url = /v=(.*)/.match(@personality_db.video_link)[1]
    @body = @personality_db.body
    @step_1 = @personality_db.step_1
    @step_2 = @personality_db.step_2
    @step_3 = @personality_db.step_3
    @step_4 = @personality_db.step_4
    @step_5 = @personality_db.step_5
    end
    if session[:token]
      me = FbGraph::User.me(session[:token])
      @facebook_friends = me.friends
      @users_facebook_ids = User.all.map { |u| u.facebook_id }
    end      
  end
  
  def edit #Add a code so that users can follow. ie Professors/employers use this
    @user = current_user 
    @followers = @user.user_followers#array of users that follow current_user 
  end

  def update
    @user = current_user
    if params[:user][:code].nil? || params[:user][:code].empty?
      flash[:alert] = "Code cannot be empty"
      redirect_to edit_user_path
    elsif @user.update_column(:code, params[:user][:code]) #@user.update_attributes(params[:user])  
      flash[:success] = "Code updated."
      redirect_to edit_user_path
    elsif
      flash[:alert] = "Unable to create code"
      redirect_to edit_user_path
    end
  end

  def follow_code
    @user = current_user
  end
  
  def followsubmit
    if User.find_by_code(params[:code_string]) and !params[:code_string].empty?
      @parent = User.find_by_code(params[:code_string])
      @child = current_user
      @child.follow(@parent)
      flash[:success] = 'Code entered.'
      redirect_to root_path
    else
      flash[:alert] = 'Code not correct.'
      redirect_to follow_code_path
    end
    
  end

  def destroy
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = 'User was successfully created'
      sign_in_user @user
      redirect_to :survey
    else
      redirect_to :signup
      flash[:alert] = "Account could not successfully created because:\n"
      @user.errors.full_messages.each { |x| flash[:alert] << x + ",\n" }
    end
  end
  
  def facebook_invite_form
    if request.post?
      begin
        user = FbGraph::User.new(params[:facebook_id], :access_token => params[:access_token])
        user.feed!(:message => params[:message])
        #user = FbGraph::User.me(session[:token])
        #user.feed!(:message => params[:message], :to => params[:facebook_id])
        flash[:success] = 'Massage has been posted successfully'
      rescue => e
       flash[:alert] = e.message
      end  
    else
      user_survey = current_user.survey
      @profile = nil
      if user_survey
        personality_type = user_survey.personality_type
        @profile = Profile.find_by_personality_type(personality_type)
      end      
    end    
  end
  
  def profile_tips
   user = User.find_by_facebook_id(params[:facebook_id])
   if user and user.survey
     personality_type = user.survey.personality_type
     @profile = Profile.find_by_personality_type(personality_type)
   else
     @profile = nil
   end    
  end
  
end
