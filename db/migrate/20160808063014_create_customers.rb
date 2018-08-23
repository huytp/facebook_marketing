class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :mac
      t.datetime :expired_time
      t.references :user, index: true
      t.string :full_name
      t.string :email
      t.string :phone
      t.boolean :ban, default: false
      t.timestamps
    end
  end
end
