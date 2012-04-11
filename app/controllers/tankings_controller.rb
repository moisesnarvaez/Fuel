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
		
		if(params[:station_name].length > 0)
			@station = Station.new(:name => params[:station_name], :user_id => current_user.id)
			if @station.save
				params[:tanking][:station_id] = @station.id
			else
				@tanking = Tanking.new(params[:tanking])
        		@tanking.errors[:station_id] = ": Actually exist the station "+params[:station_name]+", please select it."
				if(params[:id])
		          render :action => "edit"
		        else
		          render :action => "new"
		        end
		    end	
		end
	end

	def index
		@tankings = Tanking.select('"tankings"."id", name, mark, model, year, date, money, gal, km').joins(:car, :station).where(:user_id => current_user.id).order("date DESC")
	end

	def new
		@tanking = Tanking.new
	end

	def edit
	end

	def update
	    respond_to do |format|
	      if @tanking.update_attributes(params[:tanking])
	        format.html { redirect_to(tankings_url, :notice => 'Tanking was successfully updated.') }
	        format.xml  { render :xml => @tanking, :status => :created, :location => @tanking }
	      else
	        format.html { render :action => "new" }
	        format.xml  { render :xml => @tanking.errors, :status => :unprocessable_entity }
	      end
	    end
	end

	def create
		@tanking = Tanking.new(params[:tanking])
	    respond_to do |format|
	      if @tanking.save
	        format.html { redirect_to(tankings_url, :notice => 'Tanking was successfully created.') }
	        format.xml  { render :xml => @tanking, :status => :created, :location => @tanking }
	      else
	        format.html { render :action => "new" }
	        format.xml  { render :xml => @tanking.errors, :status => :unprocessable_entity }
	      end
	    end
	end

	def destroy
		@tanking.destroy

		respond_to do |format|
			format.html { redirect_to(tankings_url, :notice => 'Tanking was successfully deleted.') }
			format.xml  { head :ok }
		end
	end
end
