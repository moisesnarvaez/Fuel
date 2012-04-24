class Fuel.Routers.CarsRouter extends Backbone.Router
  initialize: ->
    @cars = new Fuel.Collections.CarsCollection()
    @stations = new Fuel.Collections.StationCollection()
    @stations.fetch()
    @tankings = new Array()
    @cars.fetch({
      success: =>
        ###
        @cars.each (car) =>
          @fillCarTankings(car)
        ###
    })
    

  routes:
    "cars"          : "index"
    "cars/new"      : "newCar"
    "cars/:id"      : "show"
    "cars/:id/edit" : "edit"

  newCar: ->
    @view = new Fuel.Views.Cars.NewView(collection: @cars)
    $("#car_detail").html(@view.render().el)
    $("#car_tankings").html('')

  index: ->
    @view = new Fuel.Views.Cars.IndexView(cars: @cars)
    $("#content").html(@view.render().el)
    $("#car_detail").html('')
  
  fillCarTankings: (car) ->
    car_id = car.get('id')
    @tankings[car_id] = new Fuel.Collections.TankingsCollection()
    @tankings[car_id].fetch({ data: $.param({ car_id : car_id })})

  show: (id) ->
    car_id = id
    car = @cars.get(id)
    @view_detail = new Fuel.Views.Cars.ShowView(model: car)
    $("#car_detail").html(@view_detail.render().el)

    tank_temp = new Fuel.Collections.TankingsCollection()
    tank_temp.fetch({ data: $.param({ car_id : id })})
    tank_temp.reset(@tankings[car_id])

    @view_tankings = new Fuel.Views.Tankings.IndexView(tankings: tank_temp, attributes: { car_id: car_id, stations : @stations })
    $("#car_tankings").html(@view_tankings.render().el)

  edit: (id) ->
    car = @cars.get(id)
    @view_detail = new Fuel.Views.Cars.NewView({model: car})
    $("#car_detail").html(@view_detail.render().el)
  