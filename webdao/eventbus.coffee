###*
  @fileoverview webdao.eventbus
###
#class webdao.Eventbus extends este.Base
goog.provide 'webdao.Eventbus'
goog.require 'webdao.Eventbusactual'
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
    Simple attr
  ###
  get: ->
    11

  ###*
    Simple attr
  ###
  emmit: (e) ->
    @dispatchEvent e

      
goog.addSingletonGetter webdao.Eventbus

