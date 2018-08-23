class ChangeStringFormatInCustomers < ActiveRecord::Migration
  def change
    def up
    change_column :customers, :full_name, :text
  end

  def down
    change_column :customers, :full_name, :string
  end
  end
end
