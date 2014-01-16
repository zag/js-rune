###*
  @fileoverview Reflect class for classes using events.
###
goog.provide 'rune.Reflect'
goog.require 'goog.asserts'
goog.require 'rune.Base'
goog.require 'rune.global'

class rune.Reflect extends rune.Base

  ###*
    @constructor 
    @extends {goog.events.EventTarget}
  ###
  constructor: (obj)->
    v = rune.global.get obj
    if v
       return v
    @parent_ = obj
    rune.global.put(obj, @)
    super()
    
  ###*
    @type {}
  ###
  parent_ : null

  ###*
    @protected
  ###
  getHandler: ->
    @handler_ ?= new goog.events.EventHandler @parent_


