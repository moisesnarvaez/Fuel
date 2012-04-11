class CreateTankings < ActiveRecord::Migration
  def change
    create_table :tankings do |t|
      t.integer :user_id
      t.integer :car_id
      t.integer :station_id
      t.string :money
      t.string :gal
      t.string :km
      t.date :date

      t.timestamps
    end
  end
end
