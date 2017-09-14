class CreateQuestionAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :question_attempts do |t|
      t.references :question, foreign_key: true
      t.references :user, foreign_key: true
      t.binary :user_options

      t.timestamps
    end
  end
end
