-- Vector Class
-- Created for:
--  Handling markers around the map.
--  Vector maths utilities.
-- Usage:
--   Vector = exports("meta_libs"):Vector()
--   distance = Vector.Dist(v1,v2)
--   recommended not to use every frame.
--   exports have terrible performance.

Vector = {
  Dist = function(v1,v2)  
    if not v1 or not v2 or not v1.x or not v2.x or not v1.z or not v2.z then return 0; end
    return math.sqrt( ((v1.x - v2.x)*(v1.x-v2.x)) + ((v1.y - v2.y)*(v1.y-v2.y)) + ((v1.z-v2.z)*(v1.z-v2.z)) )
  end,

  SqMagnitude = function(v)
     return ( (v.x * v.x) + (v.y * v.y) + (v.z * v.z) )
  end, 

  Length = function(v)
    return math.sqrt( (v.x * v.x)+(v.y * v.y)+(v.z * v.z) )
  end,

  Clamp = function(v,maxLength)  
    if Vector.SqMagnitude(v) > (maxLength * maxLength) then    
      v = Vector.SetNormalize(v)
      v = Vector.Multi(v,maxLength)        
    end
    return v
  end,

  Normalize = function(v)
    local len = Vector.Length(v)
    return vector3(v.x / len, v.y / len, v.z / len)
  end,

  SetNormalize = function(v)
    local num = Vector.Length(v)      
    if num == 1 then
      return v
    elseif num > 1e-5 then    
      return Vector.Div(v,num)
    else    
      return vector3(0,0,0)
    end 
  end,

  Div = function(v,d)
    local x = v.x / d
    local y = v.y / d
    local z = v.z / d    
    return vector3(x,y,z)
  end,

  Multi = function(v,q)
    local x,y,z
    local retVec
    if type(q) == "number" then
      x = v.x * q
      y = v.y * q
      z = v.z * q
      retVec = vector3(x,y,z)
    end    
    return retVec
  end,

  PointOnSphere = function(alt,azu,radius,orgX,orgY,orgZ)
    local toradians = 0.017453292384744
    alt             = ( tonumber(alt      or 0) or 0 ) * toradians
    azu             = ( tonumber(azu      or 0) or 0 ) * toradians
    radius          = ( tonumber(radius   or 0) or 0 )
    orgX            = ( tonumber(orgX     or 0) or 0 )
    orgY            = ( tonumber(orgY     or 0) or 0 )
    orgZ            = ( tonumber(orgZ     or 0) or 0 )

    local x = orgX + radius * math.sin( azu ) * math.cos( alt )
    local y = orgY + radius * math.cos( azu ) * math.cos( alt )
    local z = orgZ + radius * math.sin( alt )

    return vector3(x,y,z)
  end,

  ClampCircle = function(x,y,radius)
    x      = ( tonumber(x or 0)      or 0 )
    y      = ( tonumber(y or 0)      or 0 )
    radius = ( tonumber(radius or 0) or 0 )

    local d = math.sqrt(x*x+y*y)
    d = radius / d

    if d < 1 then x = x * (d/radius)*radius; y = y * (d/radius)*radius; end
    return x,y
  end,

  RotationToDirection = function(rot)
    if     ( rot == nil ) then rot = GetGameplayCamRot(2);  end
    local  rotZ = rot.z  * ( 3.141593 / 180.0 )
    local  rotX = rot.x  * ( 3.141593 / 180.0 )
    local  c = math.cos(rotX);
    local  multXY = math.abs(c)
    local  res = vector3( ( math.sin(rotZ) * -1 )*multXY, math.cos(rotZ)*multXY, math.sin(rotX) )
    return res
  end,

  InfrontOfCam = function(...)
    local unpack   = table.unpack
    local coords,direction = GetGameplayCamCoord(), Vector.RotationToDirection()
    local inTable  = {...}
    local retTable = {}

    if ( #inTable == 0 ) or ( inTable[1] < 0.000001 ) then inTable[1] = 0.000001 ; end

    for k,distance in pairs(inTable) do
      if ( type(distance) == "number" )
      then
        if    ( distance == 0 )
        then
          retTable[k] = coords
        else
          retTable[k] =
            vector3(
              coords.x + ( distance*direction.x ),
              coords.y + ( distance*direction.y ),
              coords.z + ( distance*direction.z )
            )
        end
      end
    end
    return unpack(retTable)
  end
}

exports('Vector', function() return Vector; end)