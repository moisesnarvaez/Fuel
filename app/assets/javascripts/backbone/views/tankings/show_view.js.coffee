Fuel.Views.Tankings ||= {}

class Fuel.Views.Tankings.ShowView extends Backbone.View
  template: JST["backbone/templates/tankings/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
