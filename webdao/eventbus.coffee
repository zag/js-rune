###*
  @fileoverview webdao.eventbus
###
#class webdao.Eventbus extends este.Base
goog.provide 'webdao.Eventbus'
goog.require 'este.Base'

#class webdao
webdao.getEventbus = ->
  webdao.Eventbus.getInstance()

class webdao.Eventbus extends este.Base

  ###*
    @constructor
    @extends {este.Base}
  ###
  constructor: ->
    super()
  
  ###*
    Bus emmit
  ###
  emmit: (e) ->
    @dispatchEvent e

      
goog.addSingletonGetter webdao.Eventbus

