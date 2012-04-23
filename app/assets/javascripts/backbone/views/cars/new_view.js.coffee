Fuel.Views.Cars ||= {}

class Fuel.Views.Cars.NewView extends Backbone.View
  template: JST["backbone/templates/cars/new"]

  events:
    "submit #new-car": "save"

  constructor: (options) ->
    super(options)
    @options = options

    if @options.model
      @model = @options.model
    else
      @model = new @collection.model()  
    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    attributes = { mark : $("#mark").val(), model : $("#model").val(), year : $("#year").val(), color : $("#color").val() }
    @model.set( attributes )
    @model.unset("errors")
    
    if @options.model
      @model.save(attributes,
        wait: true
        success : (car) =>
          @model = car
          window.location.hash = "#cars/#{@model.id}"
        error: @handleError
      )
    else
      @collection.create(attributes,{
        wait: true
        success: (car) =>
          @model = car
          window.location.hash = "#cars/#{@model.id}"
        error: @handleError
      })
  
  handleError: (car, jqXHR) =>
    if jqXHR.responseText.length
      errors = $.parseJSON(jqXHR.responseText)
      msj = '<ul>'
      for attribute, messages of errors
          msj += "<li>#{attribute} #{message}</li>"  for message in messages
      msj += "</ul>"
      @model.set(errors : msj )

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this