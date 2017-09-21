moon = require"moon"

sm = setmetatable
infix = (f) ->
  mt = { __sub: (self, b) -> return f(self[1], b) }
  return sm({}, { __sub: (a, _) -> return sm({ a }, mt) })


merge_postfix = (a, b) ->
    res = {}
    for key, value in pairs b
        if a[key] != nil
            if type(a[key]) == "table"
                if #a[key] == 0
                    old = a[key]
                    a[key] = {old, value}
                else
                    table.insert(a[key], value)
        else
            a[key] = value
    return a

merge = infix(merge_postfix)

scenario = (cfg) ->
    moon.p(cfg)

SIDE = () -> {
    side:
        side: 5
        controller: "someone"
    event:
        name: "second"
        sowas: true
}


scenario{

    event:
        name: "first"

    side:
        side: 1
        controller: "human"

    <{side:{side2: 2, controller: "player"}}

    side:
        side: 3
        controller: "ai"

    <{
        side:
            side: 4
            controller: "human"
    }

    <SIDE!
}
