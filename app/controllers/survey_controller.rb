class SurveyController < ApplicationController

  before_filter :auth_user

  def new

  end

  def create
    if params.has_key?(:type) && !Survey.personality_types.include?(params[:type][:type].upcase)
      flash[:notice] = "That is not a correct personality type"
      redirect_to :survey and return
    elsif params.has_key?(:type)
      @survey_params = Survey.organize(params[:type])
      @survey_params[:user_id] = current_user.id
    else
      puts "HELLLOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
      puts !params[:input]
      puts params[:input].length < 50
      puts params[:input][:manual] == nil
      if !params[:input] or params[:input].length < 50 #or params[:input][:manual] == nil
        flash[:notice] = "Please complete the majority of the survey to generate an accurate personality match for you!"
        redirect_to :survey and return
      end
      @survey_params = Survey.organize(params[:input])
      @survey_params[:user_id] = current_user.id
    end

    @survey = Survey.new(@survey_params)
    if @survey.save
      #survey answers update
      survey_answers_update(@survey.personality_type, params[:input])
      flash[:notice] = "Welcome to LeadU!"
      redirect_to root_path
    else
      flash[:notice] = "You may have entered a field wrong"
      render :survey
    end

    current_user.survey = @survey
  end
  
  #survery answers update
  def survey_answers_update(personality_type, params)
    arr_per_type = personality_type.chars.to_a
    if arr_per_type
        params.each do |key,value|
          survey_ans = SurveyAnswer.find_by_question_id(key)
          if survey_ans
            if( /EI-\d*/.match(key))
              if arr_per_type[0] == 'E' and value.to_i == 1
                survey_ans.correctly_matched += 1
                survey_ans.total_matched += 1
              else
                survey_ans.total_matched += 1   
              end
            end
            if( /TF-\d*/.match(key))
              if arr_per_type[1] == 'T' and value.to_i == 1
                survey_ans.correctly_matched += 1
                survey_ans.total_matched += 1
              else
                survey_ans.total_matched += 1   
              end
            end
            if( /SN-\d*/.match(key))
              if arr_per_type[2] == 'S' and value.to_i == 1
                survey_ans.correctly_matched += 1
                survey_ans.total_matched += 1
              else
                survey_ans.total_matched += 1   
              end
            end
            if( /JP-\d*/.match(key))
              if arr_per_type[3] == 'J' and value.to_i == 1
                survey_ans.correctly_matched += 1
                survey_ans.total_matched += 1
              else
                survey_ans.total_matched += 1   
              end
            end
            survey_ans.save
          end  
        end
    end      
  end

  def destroy
  end

end
