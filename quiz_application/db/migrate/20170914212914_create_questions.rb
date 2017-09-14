class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :quiz, foreign_key: true
      t.string :question_statement
      t.string :option_1
      t.string :option_2
      t.string :option_3
      t.string :option_4
      t.binary :correct_options

      t.timestamps
    end
  end
end
