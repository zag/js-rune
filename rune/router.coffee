###*
  @fileoverview rune.router
  @namespace rune.router

      var router = rune.router({
             routes : { 
                 '/' : '<p>1qweqweqwe</p>',
                 '/create' : '<i>2qweqweqw</i>',
                  '/list' : octonus.app.ui.diamonds.ListView()
              }});
    rune.react.render( router, document.getElementById('app1') ); 

###
goog.provide 'rune.router'
goog.require 'rune.react'
goog.require 'rune.Eventbus'
rune.router = rune.react.create (`/** @lends {React.ReactComponent.prototype} */`)
  getDefaultProps: ->
    'current_route' : ''
    'routes': {}
  
  getInitialState: ->
    @on rune.Eventbus.getInstance(), 'navigate', @onNavigate
    'routes': @props['routes']
    'current_route': @props['current_route']

  onNavigate: (e) ->
    @setState current_route: e.token

  render: ->
    text = @props['routes']['/' + @state['current_route']]
    text = text() if goog.isFunction text 
    if text is undefined
         return @span "Cant map route for #{ '/' + @state['current_route']}"
    if typeof( text ) == 'string'
       return @div dangerouslySetInnerHTML: { __html: text }
    text


