GetKeyHeld = function(key)
  return (IsControlPressed(0,key) or IsDisabledControlPressed(0,key))
end

GetKeyDown = function(key)
  return (IsControlJustPressed(0,key) or IsDisabledControlJustPressed(0,key))
end

GetKeyUp = function(key)
  return (IsControlJustReleased(0,key) or IsDisabledControlJustReleased(0,key))
end

exports("GetKeyHeld",GetKeyHeld)
exports("GetKeyDown",GetKeyDown)
exports("GetKeyUp",GetKeyUp)