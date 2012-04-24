class Fuel.Models.Tanking extends Backbone.Model
  paramRoot: 'tanking'

  defaults:
    "car_id" : ""
    "station_id" : ""
    "name" : ""
    "money" : ""
    "gal" : ""
    "km" : ""
    "date" : "2012-01-01"

class Fuel.Collections.TankingsCollection extends Backbone.Collection
  model: Fuel.Models.Tanking
  url: '/api/tankings'
  comparator: (tanking) ->
    String.fromCharCode.apply String, _.map(tanking.get("date").split(""), (c) ->
      0xffff - c.charCodeAt()
    )