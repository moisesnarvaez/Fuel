Fuel.Views.Tankings ||= {}

class Fuel.Views.Tankings.TankingView extends Backbone.View
  initialize: ->
    @model.on('change', @render, this)
    @model.on('destroy', @remove, this)

  template: JST["backbone/templates/tankings/tanking"]

  events:
    "click .destroy" : "destroy"
    "click .edit" : "edit"

  tagName: "tr"

  destroy: ->
    @model.destroy()
    @collection.remove(@model)

  edit: ->
    view = new Fuel.Views.Tankings.NewView(collection: @collection, model: @model, attributes:{ car_id: @options.attributes.car_id, stations : @options.attributes.stations })
    view.render()
    $modalEl = $("#modal")
    $modalEl.html(view.el)
    $modalEl.modal()
    view.addAllStation()
    $('#date').datepicker({ format: 'yyyy-mm-dd'}).on "changeDate", (ev) ->
      $("#date").datepicker "hide"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
