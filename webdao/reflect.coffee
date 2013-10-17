###*
  @fileoverview Reflect class for classes using events.
###
goog.provide 'webdao.Reflect'
goog.require 'goog.asserts'
goog.require 'webdao.Base'
goog.require 'webdao.global'

class webdao.Reflect extends webdao.Base

  ###*
    @constructor 
    @extends {goog.events.EventTarget}
  ###
  constructor: (obj)->
    v = webdao.global.get obj
    if v
       return v
    @parent_ = obj
    webdao.global.put(obj, @)
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


