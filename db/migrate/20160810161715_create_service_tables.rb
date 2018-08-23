class CreateServiceTables < ActiveRecord::Migration
  def change
    create_table :service_tables do |t|
      t.integer :price
      t.integer :day_of_use

      t.timestamps null: false
    end
  end
end
