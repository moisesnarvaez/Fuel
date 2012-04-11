class RemoveNameFromCar < ActiveRecord::Migration
  def up
    remove_column :cars, :name
      end

  def down
    add_column :cars, :name, :string
  end
end
