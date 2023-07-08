--  local myData = {
--    test = true,
--    num = 1,
--    str = "testing",
--    tab = {
--      tabTest = false,
--      tabNum = 2,
--      tabStr = "test",
--      tabPos = vector3(155.5,200.0,200.0),
--      tabSub = {
--        subTest = true,
--        subStr = "testing",
--        subPos = vector3(155.5,200.0,200.0),
--      },
--    },
--    myPos = vector3(155.5,200.0,200.0),
--  }
--  
--  print(json.stringify("myData",myData))
--  > myData={"num":1,"myPos":{"x":155.5,"y":200.0,"z":200.0},"test":true,"tab":{"tabcfx> Str":"test","tabSub":{"subPos":{"x":155.5,"y":200.0,"z":200.0},"subTest":true,"subStr":"testing"},"tabTest":false,"tabNum":2,"tabPos":{"x":155.5,"y":200.0,"z":200.0}},"str":"testing"}

js = {json or {}}
js.encode_old = function(tab)
  local isIpair = table.isIpair(tab)
  local buffer = {[1]=(isIpair and "[" or "{")}
  for k,v in pairs(tab) do
    local sBuffer = (isIpair and {} or (type(k) == "string" and {[1]="\"",[2]=tostring(k),[3]="\":"} or {[1]=tostring(k),[2]=":"}))
    local t = type(v)
    if t == "table" then
      sBuffer[#sBuffer+1] = js.encode_old(v)
    elseif t == "number" or t == "boolean" then
      sBuffer[#sBuffer+1] = tostring(v)
    else
      sBuffer[#sBuffer+1] = tostring(v)
    end

    if next(tab,k) then
      buffer[#buffer+1] = table.concat(sBuffer)..','
    else      
      buffer[#buffer+1] = table.concat(sBuffer)
    end
  end
  buffer[#buffer+1] = (isIpair and "]" or "}")
  return table.concat(buffer)
end

js.encode = function(tab,itering)
  for k,v in pairs(tab) do
    local t = type(v)
    if t == "vector2" or t == "vector3" or t == "vector4" then
      if t == "vector2" then
        tab[k] = {["x"] = v.x,["y"] = v.y}
      elseif t == "vector3" then
        tab[k] = {["x"] = v.x,["y"] = v.y,["z"] = v.z}
      elseif t == "vector4" then
        tab[k] = {["x"] = v.x,["y"] = v.y,["z"] = v.z,["w"] = v.w}
      end
    elseif t == "table" then
      tab[k] = js.encode(v,true)
    elseif t == "string" then
      tab[k] = '"'..v..'"'
    else
      tab[k] = v
    end
  end

  if itering then 
    return tab
  else 
    return js.encode_old(tab)
  end
end

js.stringify = function(k,t)
  local b = {[1]=k.."=",[2]=js.encode(t)}
  return table.concat(b)
end

exports('Json',function(...) return js; end)