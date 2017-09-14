json.extract! question, :id, :quiz_id, :question_statement, :option_1, :option_2, :option_3, :option_4, :correct_options, :created_at, :updated_at
json.url question_url(question, format: :json)
