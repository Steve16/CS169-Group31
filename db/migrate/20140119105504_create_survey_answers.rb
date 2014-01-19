class CreateSurveyAnswers < ActiveRecord::Migration
  def change
    create_table :survey_answers do |t|
      t.string :question_id
      t.integer :correctly_matched, :default => 0
      t.integer :total_matched, :default => 0
      t.timestamps
    end
    
    print("Adding survey answers...\n")
    for i in 1..10
      SurveyAnswer.create(:question_id => "EI-#{i}")
    end
    for i in 1..21
      SurveyAnswer.create(:question_id => "SN-#{i}")
    end    
    for i in 1..19
      SurveyAnswer.create(:question_id => "TF-#{i}")
    end
    for i in 1..20
      SurveyAnswer.create(:question_id => "JP-#{i}")
    end
  end
end
