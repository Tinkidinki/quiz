class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.integer :total_score ,default: 0 
      t.boolean :admin

      t.timestamps
    end
  end
end
