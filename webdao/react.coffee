###*
  @fileoverview webdao.react.
  @namespace webdao.react
###
goog.provide 'webdao.react'
goog.provide 'webdao.react.create'
goog.provide 'webdao.react.render'

goog.require 'este.array'
goog.require 'este.thirdParty.react'
goog.require 'goog.asserts'
goog.require 'goog.object'
goog.require 'webdao.Eventbus'
goog.require 'webdao.Reflect'
goog.require 'goog.events.Event'

###*
  Creates React factory with mixined template sugar methods. It allows us to
  use "this.h3 'Foo'" instead of verbose "React.DOM.h3 null, 'Foo'".
  @param {Object} proto
  @return {function(*=, *=): React.ReactComponent}
###
webdao.react.create = (proto) ->
  webdao.react.syntaxSugarize proto
  proto.emmit = (type, params ) ->
      ev  = new goog.events.Event type, @
      ev.param = params
      webdao.Eventbus.getInstance().emmit ev
  proto.on = (src, type, fn, capture, handler) ->
    v = new webdao.Reflect @
    v.on src, type, fn, capture, handler
 
  factory = React.createClass (`/** @lends {React.ReactComponent.prototype} */`) proto
  webdao.react.improve factory

###*
  Render React component.
  @param {React.ReactComponent} component
  @param {Element} container
  @return {React.ReactComponent} Component instance rendered in container.
###
webdao.react.render = (component, container) ->
  React.renderComponent component, container

###*
  Copy React.DOM methods into React component prototype.
  @param {Object} proto
  @private
###
webdao.react.syntaxSugarize = (proto) ->
  for tag, factory of React.DOM
    continue if !goog.isFunction factory
    proto[tag] = webdao.react.improve factory
  return

###*
  Allow to use this.h3 'Foo' instead of verbose React.DOM.h3 null, 'Foo'.
  @param {Function} factory
  @return {function(*=, *=): React.ReactComponent}
  @private
###
webdao.react.improve = (factory) ->
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
