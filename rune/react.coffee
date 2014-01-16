###*
  @fileoverview rune.react.
  @namespace rune.react
###
goog.provide 'rune.react'
goog.provide 'rune.react.create'
goog.provide 'rune.react.render'

goog.require 'este.array'
goog.require 'este.thirdParty.react'
goog.require 'goog.asserts'
goog.require 'goog.object'
goog.require 'rune.Eventbus'
goog.require 'rune.Reflect'
goog.require 'goog.events.Event'

###*
  Creates React factory with mixined template sugar methods. It allows us to
  use "this.h3 'Foo'" instead of verbose "React.DOM.h3 null, 'Foo'".
  @param {Object} proto
  @return {function(*=, *=): React.ReactComponent}
###
rune.react.create = (proto) ->
  rune.react.syntaxSugarize proto
  proto.emmit = (type, params ) ->
      ev  = new goog.events.Event type, @
      ev.param = params
      rune.Eventbus.getInstance().emmit ev
  proto.on = (src, type, fn, capture, handler) ->
    v = new rune.Reflect @
    v.on src, type, fn, capture, handler
 
  factory = React.createClass (`/** @lends {React.ReactComponent.prototype} */`) proto
  rune.react.improve factory

###*
  Render React component.
  @param {React.ReactComponent} component
  @param {Element} container
  @return {React.ReactComponent} Component instance rendered in container.
###
rune.react.render = (component, container) ->
  React.renderComponent component, container

###*
  Copy React.DOM methods into React component prototype.
  @param {Object} proto
  @private
###
rune.react.syntaxSugarize = (proto) ->
  for tag, factory of React.DOM
    continue if !goog.isFunction factory
    proto[tag] = rune.react.improve factory
  return

###*
  Allow to use this.h3 'Foo' instead of verbose React.DOM.h3 null, 'Foo'.
  @param {Function} factory
  @return {function(*=, *=): React.ReactComponent}
  @private
###
rune.react.improve = (factory) ->
  ###*
    @param {*=} arg1
    @param {*=} arg2
  ###
  (arg1, arg2) ->
    if !arguments.length
      return factory.call @

    props = arg1
    children = arg2
    if props.constructor != Object
      children = props
      props = null

    if goog.isArray children
      goog.asserts.assertArray children
      children = goog.array.flatten children
      este.array.removeUndefined children

    if children?
      factory.call @, props, children
    else
      factory.call @, props
