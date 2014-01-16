###*
  @fileoverview Base class for classes using events.
###
goog.provide 'rune.Base'

goog.require 'goog.asserts'
goog.require 'goog.events.EventHandler'
goog.require 'goog.events.EventTarget'

class rune.Base extends goog.events.EventTarget

  ###*
    @constructor
    @extends {goog.events.EventTarget}
  ###
  constructor: ->
    super()

  ###*
    @type {goog.events.EventHandler}
    @private
  ###
  handler_: null

  ###*
    Alias for .listen.
    @param {goog.events.ListenableType} src Event source.
    @param {string|Array.<string>} type Event type to listen for or array of
      event types.
    @param {Function|Object=} fn Optional callback function to be used as
      the listener or an object with handleEvent function.
    @param {boolean=} capture Optional whether to use capture phase.
    @param {Object=} handler Object in whose scope to call the listener.
    @protected
  ###
  on: (src, type, fn, capture, handler) ->
    @getHandler().listen src, type, fn, capture, handler

  ###*
    Alias for .listenOnce.
    @param {goog.events.ListenableType} src Event source.
    @param {string|Array.<string>} type Event type to listen for or array of
      event types.
    @param {Function|Object=} fn Optional callback function to be used as
      the listener or an object with handleEvent function.
    @param {boolean=} capture Optional whether to use capture phase.
    @param {Object=} handler Object in whose scope to call the listener.
    @protected
  ###
  once: (src, type, fn, capture, handler) ->
    @getHandler().listenOnce src, type, fn, capture, handler

  ###*
    Alias for .unlisten.
    @param {goog.events.ListenableType} src Event source.
    @param {string|Array.<string>} type Event type to listen for or array of
      event types.
    @param {Function|Object=} fn Optional callback function to be used as
      the listener or an object with handleEvent function.
    @param {boolean=} capture Optional whether to use capture phase.
    @param {Object=} handler Object in whose scope to call the listener.
    @protected
  ###
  off: (src, type, fn, capture, handler) ->
    @getHandler().unlisten src, type, fn, capture, handler

  ###*
    @protected
  ###
  getHandler: ->
    @handler_ ?= new goog.events.EventHandler @


  ###*
    @override
  ###
  disposeInternal: ->
    @handler_?.dispose()
    super()
    return

