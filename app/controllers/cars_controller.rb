class CarsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@cars = Car.where("user_id= ?", current_user.id)

		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @cars }
	    end
	end

	def show
		@car = Car.find(params[:id])
		@data = Hash.new
		all_records = Tanking.where(:user_id => current_user.id, :car_id => @car.id).order("date")
		all_records.each do |row|
		  if(!@data.has_key?(row.date))
		    @data[row.date] = { :date  =>  row.date, :cars => {} }
		  end
		  #if(@data.has_key?(row.date))
		  if(!@data[row.date][:cars].has_key?(row.car_id))
		    @data[row.date][:cars][row.car_id] = {:id => row.car_id, :gal => row.gal }
		  else
		    @data[row.date][:cars][row.car_id][:gal] = @data[row.date][:cars][row.car_id][:gal].to_i + row.gal.to_i
		  end
		end
	end

	def new
		@car = Car.new
	end

	def edit
		@car = Car.find(params[:id])
	end

	def create
		params[:car][:user_id] = current_user.id
		@car = Car.new(params[:car])

	    respond_to do |format|
	      if @car.save
	        format.html { redirect_to(cars_url, :notice => 'Car was successfully created.') }
	        format.json  { render :json => @car, :status => :created, :location => @car }
	      else
	        format.html { render :action => "new" }
	        format.json  { render :json => @car.errors, :status => :unprocessable_entity }
	      end
	    end
	end

	def update
		@car = Car.find(params[:id])
		respond_to do |format|
	      if @car.update_attributes(params[:car])
	        format.html { redirect_to(cars_url, :notice => 'Car was successfully updated.') }
	        format.xml  { head :ok }
	      else
	        format.html { render :action => "edit" }
	        format.json  { render :json => @car.errors, :status => :unprocessable_entity }
	      end
		end
	end
end