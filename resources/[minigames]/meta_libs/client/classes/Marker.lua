-- Marker Class
-- Created for:
--  Easy marker creation.
-- Usage:
--  No intended usage outside of MarkerHandler.lua

Marker = function(type,posX,posY,posZ,dirX,dirY,dirZ,rotX,rotY,rotZ,scaleX,scaleY,scaleZ,red,green,blue,alpha,bobUpAndDown,faceCamera,p19,rotate,textureDict,textureName,drawOnEnts,textDist,text,doFunc,onKey,funcArgs)
  return {
    type = (type or 0),
    posX = (posX or 0.0),
    posY = (posY or 0.0),
    posZ = (posZ or 0.0),
    dirX = (dirX or 0.0),
    dirY = (dirY or 0.0),
    dirZ = (dirZ or 0.0),
    rotX = (rotX or 0.0),
    rotY = (rotY or 0.0),
    rotZ = (rotZ or 0.0),
    scaleX = (scaleX or 0.0),
    scaleY = (scaleY or 0.0),
    scaleZ = (scaleZ or 0.0),
    red = (red or 255),
    green = (green or 255),
    blue = (blue or 255),
    alpha = (alpha or 255),
    bobUpAndDown = (bobUpAndDown or false),
    faceCamera = (faceCamera or true),
    p19 = (p19 or false),
    rotate = (rotate or true),
    textureDict = (textureDict or nil),
    textureName = (textureName or nil),
    drawOnEnts = (drawOnEnts or nil),
    pos = vector3((posX or 0.0),(posY or 0.0),(posZ or 0.0)),
    textDist = (textDist or false),
    text = (text or false),
    doFunc = (doFunc or false),
    onKey = (onKey or false),
    funcArgs = (funcArgs or false),
  }
end


