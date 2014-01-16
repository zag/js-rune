###*
  @fileoverview rune.eventbus
###
#class rune.Eventbus extends rune.Base
goog.provide 'rune.Eventbus'
goog.require 'rune.Base'

#class rune
rune.getEventbus = ->
  rune.Eventbus.getInstance()

class rune.Eventbus extends rune.Base

  ###*
    @constructor
    @extends {rune.Base}
  ###
  constructor: ->
    super()
  
  ###*
    Bus emmit
  ###
  emmit: (e) ->
    @dispatchEvent e

      
goog.addSingletonGetter rune.Eventbus

