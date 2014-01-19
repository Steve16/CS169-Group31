ActiveAdmin.register SurveyAnswer do
  form do |f|
    f.inputs "Details" do
      f.input :question_id
      f.input :correctly_matched
      f.input :total_matched
    end
    f.buttons
  end
end
