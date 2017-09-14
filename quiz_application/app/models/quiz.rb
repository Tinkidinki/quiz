class Quiz < ApplicationRecord
    has_many :questions
    has_many :quiz_attempts
    has_many :users , through: :quiz_attempts
end
