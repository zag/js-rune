###*
  @fileoverview webdao.router
  @namespace webdao.router

      var router = webdao.router({
             routes : { 
                 '/' : '<p>1qweqweqwe</p>',
                 '/create' : '<i>2qweqweqw</i>',
                  '/list' : octonus.app.ui.diamonds.ListView()
              }});
    webdao.react.render( router, document.getElementById('app1') ); 

###
goog.provide 'webdao.router'
goog.require 'webdao.react'
goog.require 'webdao.Eventbus'
webdao.router = webdao.react.create (`/** @lends {React.ReactComponent.prototype} */`)
  getDefaultProps: ->
    'current_route' : ''
    'routes': {}
  
  getInitialState: ->
    @on webdao.Eventbus.getInstance(), 'navigate', @onNavigate
    'routes': @props['routes']
    'current_route': @props['current_route']

  onNavigate: (e) ->
    @setState current_route: e.token

  render: ->
    text = @props['routes']['/' + @state['current_route']]
    text = text() if goog.isFunction text 
    if typeof( text ) == 'string'
       return @div dangerouslySetInnerHTML: { __html: text }
    text


