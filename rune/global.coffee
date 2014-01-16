###*
  @fileoverview rune.global
###
goog.provide 'rune.global'

rune.vars =  mapping : {}

rune.global._get_map =  ->
    rune.vars.mapping ?= {}
###*

###
rune.global.put = (obj, value ) ->
   v = rune.global._get_map()
   v[goog.getUid(obj)] = value
   value


rune.global.get = (obj) ->
   v = rune.global._get_map()
   v[goog.getUid(obj)]

