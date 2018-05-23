do
  local _with_0 = require("moonscript.base")
  _with_0.insert_loader()
  if love then
    _with_0.insert_love_loader()
  end
  return _with_0
end
