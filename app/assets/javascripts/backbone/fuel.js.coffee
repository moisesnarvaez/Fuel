#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Fuel =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
  	new Fuel.Routers.HomeRouter()
  	Backbone.history.start()

window.Cars =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
  	new Fuel.Routers.CarsRouter()
