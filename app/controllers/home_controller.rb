class HomeController < ApplicationController
  before_filter :check_user, :only => :stadistics
  
  def index
  end

  def check_user
  	unless user_signed_in?
      redirect_to "/"
    end
  end

  def stadistics
    @op = 1;
    if(params[:op].to_i > 0)
      @op = params[:op].to_i
    end

  	@data = Hash.new
  	case @op
    when 1 
      all_records = Tanking.where(:user_id => current_user.id).order("date")
    	all_records.each do |row|
    		if(!@data.has_key?(row.date))
    			@data[row.date] = { :date =>  row.date, :cars => {} }
    		end
    		#if(@data.has_key?(row.date))
    		if(!@data[row.date][:cars].has_key?(row.car_id))
    			@data[row.date][:cars][row.car_id] = {:id => row.car_id, :gal => row.gal }
    		else
    			@data[row.date][:cars][row.car_id][:gal] = @data[row.date][:cars][row.car_id][:gal].to_i + row.gal.to_i
    		end
    	end
    	@cars = Car.where(:user_id => current_user.id)
    when 2
      @all_records = Tanking.select("station_id, sum(km) AS total_km, sum(gal) AS total_gas").where(:user_id => current_user.id).group("station_id")

    else
      @all_records = Tanking.select("station_id, sum(money) AS total_money, sum(gal) AS total_gas").where(:user_id => current_user.id).group("station_id")
    end
  end
end
