class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :name
      t.string :mark
      t.string :model
      t.string :year
      t.string :color
      t.integer :user_id

      t.timestamps
    end
  end
end
