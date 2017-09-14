class CreateQuizAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :quiz_attempts do |t|
      t.references :quiz, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
