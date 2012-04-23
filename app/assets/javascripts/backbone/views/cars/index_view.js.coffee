Fuel.Views.Cars ||= {}

class Fuel.Views.Cars.IndexView extends Backbone.View
  template: JST["backbone/templates/cars/index"]

  initialize: (options) ->
    @options.cars.bind('reset', @addAll)
    @options.cars.on('add', @addOne, this)

  addAll: () =>
    @options.cars.each(@addOne)

  addOne: (car) =>
    view = new Fuel.Views.Cars.CarView({model : car})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(cars: @options.cars.toJSON() ))
    @addAll()

    return this
