class User < ApplicationRecord
  has_secure_password

  has_many :question_attempts
  has_many :questions, through: :question_attempts 
  has_many :quiz_attempts
  has_many :quizzes, through: :quiz_attempts 
end
