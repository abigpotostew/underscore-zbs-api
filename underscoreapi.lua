-------------------------------------------------------------------------------
-- Underscore API for ZeroBrane Studio
-- Add this to the packages folder. Also add this line to your config file:
--    api = {[your interpreter name] = {"underscore"}}
-------------------------------------------------------------------------------

local api = {
  _ = {
    type = "lib",
    description = "Underscore library",
    childs = {
      -- iterator functions ---------------------------
      map = { type = "function", returns="(new array)", args="((iter), (func))", description=
[[Produces a new array by mapping each value in iter through a transformation function.  Aliases: collect
    _.map({1,2,3}, function(i) return i*2 end)
    => { 2,4,6 }]], },

      collect = { type = "function", returns="(new array)", args="((iter), (func))", description=
[[Produces a new array by mapping each value in iter through a transformation function.  Aliases: map
    _.collect({1,2,3}, function(i) return i*2 end)
    => { 2,4,6 }]], },
      
      each = { type = "function", returns="(input array)", args="((iter), (func))", description=
[[Passes each value to function(i) and returns the input.    Aliases: for_each
    _.each({1,2,3}, print)
    => {1,2,3}]], },

      for_each = { type = "function", returns="(input array)", args="((iter), (func))", description=
[[Passes each value to function(i) and returns the input.    Aliases: each
    _.for_each({1,2,3}, print)
    => {1,2,3}]], },
      
      select = { type = "function", returns="(modified input array)", args="((iter), (func))", description=
[[Removes items that do not match the provided criteria.    Aliases: filter
    _.select({1,2,3}, function(i) return i%2 == 1 end)
    => {1,3}]], },

      filter = { type = "function", returns="(modified input array)", args="((iter), (func))", description=
[[Removes items that do not match the provided criteria.    Aliases: select
    _.filter({1,2,3}, function(i) return i%2 == 1 end)
    => {1,3}]], },
      
      reject = { type = "function", returns="(modified input array)", args="((iter), (func))", description=
[[Removes items that match the provided criteria.
    _.reject({1,2,3}, function(i) return i%2 == 1 end)
    => {2}]], },
      
      invoke = { type = "function", returns="nil", args="((iter), (name : string))", description=
[[Calls a function with specified name on each item using the colon operator.
    Person = {}
    Person.__index = Person 
    function Person:new(name) 
      return setmetatable({ name=name }, self) 
    end 
    function Person:print() 
      print(self.name) 
    end 
    _.invoke({ Person:new("Tom"), Person:new("Dick"), Person:new("Harry") }, "print") 
    => Calls person:print() on each Person]], },
      
      pluck = { type = "function", returns="(new array)", args="((iter), (property_name : string))", description=
[[A convenient version of the common use-case of mapextracting a list of properties.
    _.pluck({ {id=1}, {id=2}, {id=3} }, 'id') 
    => { 1, 2, 3 }]], },

      reduce = { type = "function", returns="(value)", args="((iter), (memo), (func))", description=
[[Boils down a list of values into a single value. Memo is the initial state of the reduction, and each successive step of it should be returned by func.      Aliases: inject,foldl
    _.reduce({1,2,3}, 0, function(memo, i) return memo+i end)
    => 6]], },

      inject = { type = "function", returns="(value)", args="((iter), (memo), (func))", description=
[[Boils down a list of values into a single value. Memo is the initial state of the reduction, and each successive step of it should be returned by func.      Aliases: reduce,foldl
    _.inject({1,2,3}, 0, function(memo, i) return memo+i end)
    => 6]], },

      foldl = { type = "function", returns="(value)", args="((iter), (memo), (func))", description=
[[Boils down a list of values into a single value. Memo is the initial state of the reduction, and each successive step of it should be returned by func.      Aliases: inject,reduce
    _.foldl({1,2,3}, 0, function(memo, i) return memo+i end)
    => 6]], },

      max = { type = "function", returns="(value)", args="((iter), [func]", description=
[[Returns the item with the largest value. If a func is provided it will be used on each value to generate the criterion by which the value is ranked.
    _.max({1,2,3,4}) 
    => 4
    _.max({ {age=15}, {age=12}, {age=19} }, function(p) return p.age end) 
    => {age=19}]], },

      min = { type = "function", returns="(value)", args="((iter), [func])", description=
[[Returns the item with the smallest value. If a func is provided it will be used on each value to generate the criterion by which the value is ranked.
    _.max({1,2,3,4}) 
    => 1
    _.max({ {age=15}, {age=12}, {age=19} }, function(p) return p.age end) 
    => {age=12}]], },

      include = { type = "function", returns="(boolean)", args="((iter), (value))", description=
[[Returns true if the list include's value. Uses the == operator.
    _.include({1,2,3,4}, 2)
    => true
    _.include({1,3,5}, 2)
    => false]], },

      detect = { type = "function", returns="(value)", args="((iter), (func))", description=
[[Looks through a list returning the first element that matches a truth function. The function returns as soon as it finds an acceptable element.
    _.detect({1,2,3,4}, func(i) return i > 3 end)
    => 4
    _.detect({1,2,3,4}, func(i) return i > 7 end)
    => nil]], },

      all = { type = "function", returns="(boolean)", args="((iter), (func))", description=
[[Returns true if func(item) returns true for all item in items.     Aliases: every
    _.all({2,4,8}, function(i) return i%2 == 0 end)        
    => true
    _.all({1,2,3,4}, function(i) return i%2 == 0 end)        
    => false]], },

      every = { type = "function", returns="(boolean)", args="((iter), (func))", description=
[[Returns true if func(item) returns true for all item in items.     Aliases: all
    _.every({2,4,8}, function(i) return i%2 == 0 end)        
    => true
    _.every({1,2,3,4}, function(i) return i%2 == 0 end)        
    => false]], },

      any = { type = "function", returns="(boolean)", args="((iter), (func))", description=
[[Returns true if func(item) returns true for any item in items.     Aliases: some
    _.any({1,2,3,4}, function(i) return i%2 == 0 end)        
    => true
    _.any({1,3,5}, function(i) return i%2 == 0 end)        
    => false]], },

      some = { type = "function", returns="(boolean)", args="((iter), (func))", description=
[[Returns true if func(item) returns true for any item in items.     Aliases: any
    _.some({1,2,3,4}, function(i) return i%2 == 0 end)        
    => true
    _.some({1,3,5}, function(i) return i%2 == 0 end)        
    => false]], },

      to_array = { type = "function", returns="(new array)", args="((iter)", description=
[[Collects all values into a new array.
    _.to_array(string.gmatch("dog cat goat", "%S+")) 
    => { "dog", "cat", "goat" }]], },

      sort = { type = "function", returns="(input array)", args="((iter), [comparison_func])", description=
[[Returns an array with all elements sorted by the comparison function, by default it uses the < operator. If an array is passed in it will sort the elements in place and not create a new array.
    _.sort({ 3, 1, 2}) 
    => { 1, 2, 3 }]], },

      reverse = { type = "function", returns="(new array)", args="((iter), (func))", description=
[[Iterates over all the items and returns a new array with the items in reverse order.
    _.reverse({ 1, 2, 3}) 
    => { 3, 2, 1 }]], },


-- Array Functions ---------------------------
      flatten = { type = "function", returns="(new array)", args="(array)", description=
[[Flattens a nested array (the nesting can be to any depth).
    _.flatten({1, {2}, {3, {{{4}}}}}) 
    => { 1, 2, 3, 4 }]], },

      first = { type = "function", returns="(value or new array)", args="((array), [length])", description=
[[Returns the first element of an array. Optionally it will return an array of the first n items.      Aliases: head
    _.first({1,2,3}) 
    => 1
    _.first({1,2,3}, 2) 
    => {1,2,}]], },

      head = { type = "function", returns="(value or new array)", args="((array), [length])", description=
[[Returns the first element of an array. Optionally it will return an array of the first n items.      Aliases: first
    _.head({1,2,3}) 
    => 1
    _.head({1,2,3}, 2) 
    => {1,2,}]], },

      rest = { type = "function", returns="(new array)", args="((array), [start_index)", description=
[[Returns an array of all items except the first. Optionally it will start at start_index.      Aliases: tail
    _.rest({1,2,3}) 
    => {2,3} 
    _.rest({1,2,3}, 2) 
    => {3}]], },

      tail = { type = "function", returns="(new array)", args="((array), [start_index])", description=
[[Returns an array of all items except the first. Optionally it will start at start_index.      Aliases: rest
    _.tail({1,2,3}) 
    => {2,3} 
    _.tail({1,2,3}, 2) 
    => {3}]], },

      slice = { type = "function", returns="(new array)", args="((array), (start_index), (length))", description=
[[Returns a section of an array starting with start_index of length items length.
    _.slice({ 1, 2, 3, 4, 5 }, 2, 3) 
    => { 2, 3, 4 }]], },

      push = { type = "function", returns="(input array)", args="((array), (item))", description=
[[Inserts item at the end of an array
    _.push({1,2,3}, 4)
    => {1,2,3,4}]], },

      pop = { type = "function", returns="(value)", args="(array)", description=
[[Removes and returns the last item in an array
    _.pop({1,2,3})
    => 3]], },

      shift = { type = "function", returns="(value)", args="(array)", description=
[[Removes and returns the first item in an array
    _.shift({1,2,3})
    => 1]], },

      unshift = { type = "function", returns="(input array)", args="((array), (item))", description=
[[Inserts item at the beginning of an array
_.push({1,2,3}, 4)
=> {4,1,2,3}]], },

      join = { type = "function", returns="(new array)", args="((array), [separator : string])", description=
[[Returns a string with all items in the array concatenated together with an optional separator.
    _.join({'c','a','t'})
    => "cat"
    _.join({'c','a','t'}, '/')
    => "c/a/t"]], },


-- Table Functions ---------------------------
      extend = { type = "function", returns="(dest)", args="((dest : table), (source : table)", description=
[[Copy all of the properties in the source object over to the destination object.
    _.extend({ name = 'moe' }, { age = 50 }) 
    => { name = 'moe', age = 50 }]], },
      
      keys = { type = "function", returns="(new array)", args="(table)", description=
[[Returns an array of all the property names in a table. (Note: order is not defined)
    _.keys { name = "John", age = 25 }
    => { "name", "age" }]], },

      values = { type = "function", returns="(new array)", args="(table)", description=
[[Returns an array of all the property values in a table. (Note: order is not defined)
    _.values { name = "John", age = 25 }
    => { "John", 25 }]], },

      is_empty = { type = "function", returns="(boolean)", args="(table)", description=
[[Returns true if object contains no values.
    _.is_empty({}) 
    => true 
    -.is_empty({ name = "moe" }) 
    => false]], },

-- Function Functions ---------------------------
      curry = { type = "function", returns="(new func)", args="((func), (arg)", description=
[[Creates a wrapper function substituing the supplied arg for the first argument in original function.
    function f(p1,p2) return {p1,p2} end
    g = _.curry(f, "a")
    g("b")
    => {"a","b"}
    g("c")
    => {"a","c"}]], },
      
      wrap = { type = "function", returns="(new FUNC)", args="(func, wrapper)", description=
[[Wraps the first function inside of the wrapper function, passing it as the first argument. This allows the wrapper to execute code before and after the function runs, adjust the arguments, and execute it conditionally.
    hello = function(name) 
      return "hello: "..name 
    end 
    hello = _.wrap(hello, function(func, ...) 
      return "before, "..func(...)..", after" 
    end) 
    hello('moe') 
    => before, hello: moe, after]], },

      compose = { type = "function", returns="(new func)", args="(func1, func2, [...])", description=
[[Returns the composition of a list of functions, where each function consumes the return value of the function that follows. In math terms, composing the functions f(), g(), and h() produces f(g(h())).
    greet = function(name) 
      return "hi: "..name 
    end 
    exclaim = function(statement) 
      return statement.."!" 
    end 
    welcome = _.compose(print, greet, exclaim) 
    welcome('moe') 
    => hi: moe!]], },

-- Utility Functions ---------------------------
      functions = { type = "function", returns="(array)", args="(", description=
[[Returns a list of function names in this library.
    _.functions() 
    => { 'each', 'map', 'reduce', ... }]], },

      iter = { type = "function", returns="(iter)", args="(array)", description=
[[Creates an iterator function over an array.
    for i in _.iter({1,2,3}) do
      print(i)
    end
]], valueType="iter", },

      identity = { type = "function", returns="(input value)", args="(value)", description=
[[Identity function, simply returns whatever is passed in. This function looks useless, but is used within Underscore as a default function.
    _.identity("foo") 
    => "foo"]], },

      range = { type = "function", returns="(iter)", args="(start_or_length, [end], [step])", description=
[[Iterates over a range of integers
      _.range(5,10):to_array()
      => { 5,6,7,8,9,10 }
      _.range(10):to_array()
      => { 1,2,3,4,5,6,7,8,9,10 }
      _.range(2,10,2):to_array()
      => { 2,4,6,8,10 }
      _.range(10,2,-2):to_array()
      => { 10,8,6,4,2 }]], valueType="iter" },

      is_equal = { type = "function", returns="(boolean)", args="((object), (object), [ignore_mt])", description=
[[Performs an optimized deep comparison between the two objects, to determine if they should be considered equal. By default it uses the _eql metamethod if it is present.
      _.is_equal({1,2,3},{1,2,3})
      => true
      _.is_equal({a=1,b=2},{a=1,b=2})
      => true
      _.is_equal({a=1,b=2},{a=2,b=3})
      => false]], },

    }, --childs
  },--underscore

  iter = {
    type='class',
    description = "underscore iterator function.",
    childs = {
      ['__call'] = { type="function", returns="(object)", args="((index : number))", description="returns object at index",},
    },
  }, --iter
}--api

return {
  name = "Underscore",
  description = "API for Underscore.lua - https://mirven.github.io/underscore.lua/",
  author = "mirven, ZBS API assembled by Stewart Bracken",
  version = 1,

  onRegister = function(self)
    ide:AddAPI("lua", "underscore", api)
  end,

  onUnRegister = function(self)
    ide:RemoveAPI("lua", "underscore")
  end,
}



