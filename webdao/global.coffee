###*
  @fileoverview este.react.
  @namespace este.react
###
goog.provide 'webdao.global'

webdao.vars =  mapping : {}

webdao.global._get_map =  ->
    webdao.vars.mapping ?= {}
###*

###
webdao.global.put = (obj, value ) ->
   v = webdao.global._get_map()
   v[goog.getUid(obj)] = value
   value


webdao.global.get = (obj) ->
   v = webdao.global._get_map()
   v[goog.getUid(obj)]

