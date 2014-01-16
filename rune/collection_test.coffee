suite 'rune.Collection', ->

  Collection = este.Collection
  collection =null
  storage = null
  mechanism = null
  arrangeCollectionWithItems = ->
    collection.add 'a': 1, 'aa': 1.6
    collection.add 'a': 2, 'bb': 2.5
    collection.add 'a': 3, 'cc': 3.5

  class Person extends este.Model

    constructor: (json, randomStringGenerator) ->
      super json, randomStringGenerator

    defaults:
      'title': ''
      'defaultFoo': 1

  DumpObject = (obj) ->
    od = new Object
    result = ""
    len = 0
    for property of obj
      value = obj[property]
      if typeof value is "string"
        value = "'" + value + "'"
      else if typeof value is "object"
        if value instanceof Array
          value = "[ " + value + " ]"
        else
          ood = DumpObject(value)
          value = "{ " + ood.dump + " }"
      result += "'" + property + "' : " + value + ", "
      len++
    od.dump = result.replace(/, $/, "")
    od.len = len
    od

  Model = este.Model
  setup ->
    collection = new Collection
    collection.model = Person
    mechanism = 
      set: (k,v) ->
        @[k]=v
      get: (k) ->
        @[k]
      remove: (k) ->
        delete @[k]
    storage = new este.storage.Local '','', mechanism


  suite 'constructor', ->
    test 'should allow inject json data', (done)->
      json = [
        a: 1
      ,
        b: 2
      ]
      collection = new Collection json
#      console.log "Sess", collection.toJson(true)
#      console.log "Sess", collection
      assert.deepEqual collection.toJson(true), json
      goog.events.listen collection, 'add', (e) ->
        assert.instanceOf e.added[0], Model
        done()
      collection.add a:1


    test 'test local storage', ()->
      json = [
         a: 4
       ,
         b: 34
      ]
      collection = new Collection 
      mechanism.get = (k) -> '{
        "123":  {"a" : "1", "_cid" : "123" }, 
        "456": {"a" : "2"} }'
#W          console.log "get key", k
      storage.query collection
      assert.instanceOf collection.findByClientId("123"), Model

    test 'test sort collection', (done)->
      collection = new Collection [
         a: 1
         b: 11
      ,
         a: 2
         b:22
      ]
      goog.events.listen collection, 'sort', (e) ->
        console.log "Sort", e.type
        done()
      collection.sort reversed: true, by: (item)-> item.attributes['a']
      
    test 'test sort collection', (done)->
      arrangeCollectionWithItems()
      res = collection.filter  (i)-> 
            console.log 'filter', i.get('a')
            i.get('a') > 1 && i.get('a') < 4
      console.log res
      done() if res.length
#    console.log collection.toJson()
#    test 'test local storage', (done)->


