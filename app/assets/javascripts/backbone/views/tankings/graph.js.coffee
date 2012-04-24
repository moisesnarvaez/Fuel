Fuel.Views.Tankings ||= {}

class Fuel.Views.Tankings.TankingGraph extends Backbone.View
  template: JST["backbone/templates/tankings/graph"]

  render: ->
    $(@el).html(@template( tankings : @collection.toJSON() ))
    return this
