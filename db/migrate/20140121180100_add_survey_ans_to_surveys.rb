class AddSurveyAnsToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :survery_ans, :text, :after => :user_id
  end
end
