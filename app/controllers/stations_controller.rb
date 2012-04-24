class StationsController < ApplicationController
	before_filter :authenticate_user!

	before_filter :add_user, :only => [:create]

	def add_user
		params[:station][:user_id]= current_user.id
	end

	def index
		@stations = Station.select('id, name').where("user_id = #{current_user.id}").order("name")

		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @stations }
	    end
	end

	def create
		if(params[:name].length > 0)
			@station = Station.find_or_create_by_name_and_user_id(params[:name], current_user.id)
			format.json  { render :json => @station, :status => :created, :location => @station }
		end
	end
end