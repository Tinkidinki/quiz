class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :total_score
      t.string :password_hash

      t.timestamps
    end
  end
end
