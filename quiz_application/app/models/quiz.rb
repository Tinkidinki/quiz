class Quiz < ApplicationRecord
    has_many :questions , dependent: :destroy
    has_many :quiz_attempts, dependent: :destroy
    has_many :users , through: :quiz_attempts
end
