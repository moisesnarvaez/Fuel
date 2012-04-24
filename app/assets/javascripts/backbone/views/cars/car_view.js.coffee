Fuel.Views.Cars ||= {}

class Fuel.Views.Cars.CarView extends Backbone.View
  initialize: ->
    @model.on('change', @render, this)
    @model.on('destroy', @remove, this)

  template: JST["backbone/templates/cars/car"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy({
      wait: true
      success: -> 
        $("#car_detail").html('')
        $("#car_tankings").html('')
    }) if confirm '¿Are you sure car?'

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this