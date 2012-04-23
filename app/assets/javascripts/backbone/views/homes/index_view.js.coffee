Fuel.Views.Homes ||= {}

class Fuel.Views.Homes.IndexView extends Backbone.View
  template: JST["backbone/templates/homes/index"]

  render: =>
    $(@el).html(@template())

    return this