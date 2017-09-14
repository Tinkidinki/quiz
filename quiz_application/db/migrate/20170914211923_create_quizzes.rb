class CreateQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :quizzes do |t|
      t.string :genre
      t.string :sub_genre

      t.timestamps
    end
  end
end
