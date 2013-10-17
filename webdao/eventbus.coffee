###*
  @fileoverview webdao.eventbus
###
#class webdao.Eventbus extends webdao.Base
goog.provide 'webdao.Eventbus'
goog.require 'webdao.Base'

#class webdao
webdao.getEventbus = ->
  webdao.Eventbus.getInstance()

class webdao.Eventbus extends webdao.Base

  ###*
    @constructor
    @extends {webdao.Base}
  ###
  constructor: ->
    super()
  
  ###*
    Bus emmit
  ###
  emmit: (e) ->
    @dispatchEvent e

      
goog.addSingletonGetter webdao.Eventbus

