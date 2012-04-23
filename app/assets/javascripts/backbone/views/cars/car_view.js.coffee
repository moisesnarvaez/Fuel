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
        alert "Car deleted"
    }) if confirm '¿Are you sure?'

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this