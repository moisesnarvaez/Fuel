Fuel.Views.Tankings ||= {}

class Fuel.Views.Tankings.NewView extends Backbone.View
  template: JST["backbone/templates/tankings/new"]

  events:
    "submit #new-tanking": "save"

  constructor: (options) ->
    super(options)
    @options = options
    @stations = @options.attributes.stations

    if @options.model
      @model = @options.model
    else
      @model = new @collection.model()
      @model.set('car_id', @options.attributes.car_id)


  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @name_temp = ''
    if $("#station_name").val()
      @name_temp = $("#station_name").val()
    else
      if $("#station_id").val()
        @name_temp = @stations.get($("#station_id").val()).get('name')
    

    attributes = { car_id : $("#car_id").val(), station_id : $("#station_id").val(), name : @name_temp, money : $("#money").val(), gal : $("#gal").val(), km : $("#km").val(), date : $("#date").val() }
    @model.set( attributes )
    @model.unset("errors")

    if @options.model
      @model.save(attributes,
        wait: true
        success: @handleSuccess
        error: @handleError
      )
    else
      @collection.create(attributes,{
        wait: true
        success: @handleSuccess
        error: @handleError
      })

  handleSuccess: (tanking) =>
    @stations.add({ id: tanking.get('station_id'), name : @name_temp}) unless @stations.get(tanking.get('station_id'))
    $('#modal').modal('hide')
    @collection.sort()


  handleError: (station, jqXHR) =>
    if jqXHR.responseText.length
      errors = $.parseJSON(jqXHR.responseText)
      msj = '<ul>'
      for attribute, messages of errors
          msj += "<li>#{attribute} #{message}</li>"  for message in messages
      msj += "</ul>"
      $("#modal .alert-body").html(msj)
      $("#modal .alert").slideDown()

  render: ->
    $(@el).html(@template(@model.toJSON()))
    
    return this

  addAllStation: () =>
    @stations.each(@addOneStation)  
  
  addOneStation: (station) =>
    html = "<option value='"+station.get('id')+"'"
    html += " selected='selected' " if @model.get('station_id')==station.get('id')
    html += ">"+station.get('name')+"</option>"
    $("#station_id").append(html);

  