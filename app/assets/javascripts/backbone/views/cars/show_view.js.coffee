Fuel.Views.Cars ||= {}

class Fuel.Views.Cars.ShowView extends Backbone.View
  template: JST["backbone/templates/cars/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
