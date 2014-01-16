###*
  @fileoverview HTML5 pushState and hashchange history. Facade for goog.History
  and goog.history.Html5History. It dispatches goog.history.Event.

  Some browsers fires popstate event on page load. It's wrong, because we want
  to control navigate event dispatching separately. These ghost popstate events
  are filtered via location.href check.

  @see /demos/history/historyhtml5.html
  @see /demos/history/historyhash.html
###

goog.provide 'rune.History'

goog.require 'rune.Base'
goog.require 'rune.history.TokenTransformer'
goog.require 'goog.dom'
goog.require 'goog.History'
goog.require 'goog.history.Html5History'
goog.require 'goog.labs.userAgent.platform'
goog.require 'goog.Uri'
goog.require 'rune.Eventbus'

class rune.History extends rune.Base

  ###*
    @param {boolean=} forceHash If true, este.History will degrade to hash even
    if html5history is supported.
    @param {string=} pathPrefix Path prefix to use if storing tokens in the path.
    The path prefix should start and end with slash.
    @constructor
    @extends {este.Base}
  ###
  constructor: (forceHash, pathPrefix) ->
    super

    if !pathPrefix
      pathPrefix = new goog.Uri(document.location.href).getPath()
      pathPrefix += '/' if !goog.string.endsWith pathPrefix, '/'

    @html5historyEnabled = !forceHash && History.CAN_USE_HTML5_HISTORY
    @setHistoryInternal pathPrefix ? '/'

  ###*
    http://caniuse.com/#search=pushstate
    http://webdesign.about.com/od/historyapi/a/what-is-history-api.htm
    @type {boolean}
  ###
  @CAN_USE_HTML5_HISTORY: do ->
    platform = goog.labs.userAgent.platform
    if platform.isIos()
      return platform.isVersionOrHigher 5
    if platform.isAndroid()
      return platform.isVersionOrHigher 4.2
    goog.history.Html5History.isSupported()

  ###*
    @type {boolean}
  ###
  html5historyEnabled: true

  ###*
    @type {goog.History|goog.history.Html5History}
    @protected
  ###
  history: null

  ###*
    @type {goog.events.EventHandler}
    @protected
  ###
  handler: null

  ###*
    @type {boolean}
    @protected
  ###
  silent: false

  ###*
    @type {?string}
    @protected
  ###
  currentHref: null

  ###*
    @param {string} token
    @param {boolean=} silent
  ###
  setToken: (token, @silent = false) ->
    # Token for html5 navigation has to be without '/', '#' prefixes.
    # Token for hash navigation has to be with '/' prefix, to make it look more
    # like a route and make sure it doesn't conflict with IDs on the page.
    token = @stripSlashHashPrefixes token
    if !@html5historyEnabled
      token = '/' + token
    @history.setToken token

  ###*
    @param {string} token
    @param {boolean=} silent
  ###
  replaceToken: (token, @silent = false) ->
    token = @stripSlashHashPrefixes token
    if !@html5historyEnabled
      token = '/' + token
    @history.replaceToken token

   ###*
    @param {string} str
    @return {string}
   ###
   stripSlashHashPrefixes: (str) ->
     while str && str.charAt(0) in ['/', '#']
       str = str.substring 1
     str

  ###*
    @return {string}
  ###
  getToken: ->
    @history.getToken()

  ###*
    It dispatches navigate event.
    @param {boolean=} enabled
  ###
  setEnabled: (enabled = true) ->
    if enabled
      @on @history, 'navigate', @onNavigate
    else
      @off @history, 'navigate', @onNavigate
    @history.setEnabled enabled

  ###*
    @param {string} pathPrefix
    @protected
  ###
  setHistoryInternal: (pathPrefix) ->
    if @html5historyEnabled
      transformer = new este.history.TokenTransformer()
      @history = new goog.history.Html5History undefined, transformer
      @history.setUseFragment false
      @history.setPathPrefix pathPrefix
    else
      # workaround: hidden input created in history via doc.write does not work
      input = goog.dom.createDom 'input', style: 'display: none'
      input = (`/** @type {HTMLInputElement} */`) input
      document.body.appendChild input
      @history = new goog.History false, undefined, input

  ###*
    @param {goog.history.Event} e
    @protected
  ###
  onNavigate: (e) ->
    # fix for browsers which fires popstate event on page load (webkit)
    return if @currentHref == location.href
    @currentHref = location.href

    if @silent
      @silent = false
      return

    # because hash navigation needs '/' token prefix to render '#/' path prefix
    e.token = e.token.substring 1 if !@html5historyEnabled
    
    rune.Eventbus.getInstance().emmit e
    #@dispatchEvent e

  ###*
    @override
  ###
  disposeInternal: ->
    @history.dispose()
    super()
    return

