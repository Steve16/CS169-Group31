class SurveyAnswer < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :question_id, :correctly_matched, :total_matched
end
