class Car < ActiveRecord::Base
	validates :user_id, :presence => true
	validates :mark, :presence => true
	validates :model, :presence => true
	validates :year, :presence => true

	belongs_to :user

	def name_car
		"#{self.mark} - #{self.model} (#{self.year})"
	end
end