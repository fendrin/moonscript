local moon = require("moon")
local sm = setmetatable
local infix
infix = function(f)
  local mt = {
    __sub = function(self, b)
      return f(self[1], b)
    end
  }
  return sm({ }, {
    __sub = function(a, _)
      return sm({
        a
      }, mt)
    end
  })
end
local merge_postfix
merge_postfix = function(a, b)
  local res = { }
  for key, value in pairs(b) do
    if a[key] ~= nil then
      if type(a[key]) == "table" then
        if #a[key] == 0 then
          local old = a[key]
          a[key] = {
            old,
            value
          }
        else
          table.insert(a[key], value)
        end
      end
    else
      a[key] = value
    end
  end
  return a
end
local _merge_ = infix(merge_postfix)
local scenario
scenario = function(cfg)
  return moon.p(cfg)
end
local SIDE
SIDE = function()
  return {
    side = {
      side = 5,
      controller = "someone"
    },
    event = {
      name = "second",
      sowas = true
    }
  }
end
return scenario({
  event = {
    name = "first"
  },
  side = {
    side = 1,
    controller = "human"
  }
  } -_merge_- {
    side = {
      side2 = 2,
      controller = "player"
    }
  } -_merge_- {
  side = {
    side = 3,
    controller = "ai"
  }
  } -_merge_- {
    side = {
      side = 4,
      controller = "human"
    }
  } -_merge_- {
  } -_merge_- SIDE() -_merge_- {
})