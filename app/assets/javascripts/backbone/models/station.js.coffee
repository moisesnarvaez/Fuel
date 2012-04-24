class Fuel.Models.Station extends Backbone.Model
  paramRoot: 'station'

  defaults: {
  	"name"	: ""
  }

class Fuel.Collections.StationCollection extends Backbone.Collection
  model: Fuel.Models.Station
  url: '/api/stations'