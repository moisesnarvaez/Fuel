class TankingsController < ApplicationController
	before_filter :authenticate_user!

	before_filter :get, :only => [:edit, :update, :destroy]
	before_filter :add_user, :only => [:create, :update]
	before_filter :new_station, :only => [:create, :update]
	before_filter :validate_user, :only => [:edit, :update, :destroy]

	def get
		@tanking = Tanking.find(params[:id], :conditions => ["user_id = ?", current_user.id])
	end

	def add_user
		params[:tanking][:user_id]= current_user.id
	end

	def validate_user
		if(@tanking.user_id != current_user.id)
			redirect_to(@tanking, :notice => "You can't modify this tanking")
		end
	end

	def new_station
		if(params[:tanking][:name].length > 0)
			@station = Station.find_or_create_by_name_and_user_id(params[:tanking][:name], current_user.id)
			params[:tanking][:station_id] = @station.id
		end
	end

	def index
		@tankings = Tanking.select('"tankings"."id", station_id, car_id, name, mark, model, year, date, money, gal, km').joins(:car, :station).where("tankings.user_id = #{current_user.id} AND car_id = #{params[:car_id]}").order("date DESC")

		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @tankings }
	    end
	end

	def new
		@tanking = Tanking.new
	end

	def edit
	end

	def update
		params[:tanking].delete :name
		params[:tanking].delete :mark
		params[:tanking].delete :model
		params[:tanking].delete :year
		
	    respond_to do |format|
	      if @tanking.update_attributes(params[:tanking])
	        format.html { redirect_to(tankings_url, :notice => 'Tanking was successfully updated.') }
	        format.json  { render :json => @tanking, :status => :created, :location => @tanking }
	      else
	        format.html { render :action => "new" }
	        format.json  { render :json => @tanking.errors, :status => :unprocessable_entity }
	      end
	    end
	end

	def create
		params[:tanking].delete :name
		@tanking = Tanking.new(params[:tanking])
	    respond_to do |format|
	      if @tanking.save
	        format.html { redirect_to(tankings_url, :notice => 'Tanking was successfully created.') }
	        format.json  { render :json => @tanking, :status => :created, :location => @tanking }
	      else
	        format.html { render :action => "new" }
	        format.json  { render :json => @tanking.errors, :status => :unprocessable_entity }
	      end
	    end
	end

	def destroy
		@tanking.destroy

		respond_to do |format|
			format.html { redirect_to(tankings_url, :notice => 'Tanking was successfully deleted.') }
			format.json  { head :ok }
		end
	end
end
