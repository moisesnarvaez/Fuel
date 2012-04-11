class Tanking < ActiveRecord::Base
	validates :user_id, :presence => true
	validates :car_id, :presence => true
	validates :station_id, :presence => true
	validates :money, :presence => true
	validates :gal, :presence => true
	validates :km, :presence => true

	belongs_to :user
	belongs_to :car
	belongs_to :station
end
