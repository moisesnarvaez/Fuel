class Fuel.Models.Car extends Backbone.Model
  paramRoot: 'car'

  defaults: {
  	"mark"	: ""
  	"model" : ""
  	"year"	: ""
  	"color"	: ""
  }

class Fuel.Collections.CarsCollection extends Backbone.Collection
  model: Fuel.Models.Car
  url: '/api/cars'