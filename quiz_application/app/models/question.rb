class Question < ApplicationRecord
  belongs_to :quiz
  has_many :question_attempts
  has_many :users, through: :question_attempts 
end
