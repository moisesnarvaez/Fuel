Fuel.Views.Tankings ||= {}

class Fuel.Views.Tankings.IndexView extends Backbone.View
  template: JST["backbone/templates/tankings/index"]

  initialize: () ->
    @options.tankings.bind('reset', @addAll)
    @options.tankings.bind('remove', @addAll)
  
  events:
    "click #tanking-new" : "newTanking"

  newTanking: ->
    view = new Fuel.Views.Tankings.NewView(collection: @options.tankings, attributes:{ car_id: @options.attributes.car_id, stations : @options.attributes.stations } )
    view.render()
    $modalEl = $("#modal")
    $modalEl.html(view.el)
    $modalEl.modal()
    view.addAllStation()
    $('#date').datepicker({ format: 'yyyy-mm-dd'}).on "changeDate", (ev) ->
      $("#date").datepicker "hide"

  addAll: () =>
    $("#tankings-table tbody").html('')
    @options.tankings.each(@addOne)
    @addGraph()

  addOne: (tanking) =>
    view = new Fuel.Views.Tankings.TankingView(collection: @options.tankings, model : tanking, attributes:{ car_id: @options.attributes.car_id, stations : @options.attributes.stations })
    $("#tankings-table tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(tankings: @options.tankings.toJSON() ))
    @addAll()

    return this

  addGraph: () =>
    view = new Fuel.Views.Tankings.TankingGraph({collection : @options.tankings})
    $("#tanking-graph").html(view.render().el)