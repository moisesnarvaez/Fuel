class Fuel.Routers.CarsRouter extends Backbone.Router
  initialize: ->
    @cars = new Fuel.Collections.CarsCollection()
    @cars.fetch()

  routes:
    "cars"          : "index"
    "cars/new"      : "newCar"
    "cars/:id"      : "show"
    "cars/:id/edit" : "edit"

  newCar: ->
    @view = new Fuel.Views.Cars.NewView(collection: @cars)
    $("#car_detail").html(@view.render().el)

  index: ->
    @view = new Fuel.Views.Cars.IndexView(cars: @cars)
    $("#content").html(@view.render().el)
    $("#car_detail").html('')

  show: (id) ->
    car = @cars.get(id)
    @view = new Fuel.Views.Cars.ShowView(model: car)
    $("#car_detail").html(@view.render().el)

  edit: (id) ->
    car = @cars.get(id)
    @view = new Fuel.Views.Cars.NewView({model: car})
    $("#car_detail").html(@view.render().el)
  