class Fuel.Routers.HomeRouter extends Backbone.Router
  routes:
    ""        : "index"

  index: ->
    @view = new Fuel.Views.Homes.IndexView()
    $("#content").html(@view.render().el)