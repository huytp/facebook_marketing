class CreateUserSells < ActiveRecord::Migration
  def change
    create_table :user_sells do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :customer_id
      t.integer :price

      t.timestamps null: false
    end
  end
end
