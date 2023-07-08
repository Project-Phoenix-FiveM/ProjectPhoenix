string.split = function(s,pat)
  s = tostring(s) or ""
  pat = tostring( pat ) or '%s+'
  local st, g = 1, s:gmatch("()("..pat..")")
  local function getter(segs, seps, sep, cap1, ...)  st = sep and seps + #sep  ; return s:sub(segs, (seps or 0) - 1), cap1 or sep, ...  ; end
  return function() if st then return getter(st, g()) end end
end

string.tohex = function(s,chunkSize)
  s = ( type(s) == "string" and s or type(s) == "nil" and "" or tostring(s) )
  chunkSize = chunkSize or 2048
  local rt = {}
  string.tohex_sformat   = ( string.tohex_sformat   and string.tohex_chunkSize and string.tohex_chunkSize == chunkSize and string.tohex_sformat ) or string.rep("%02X",math.min(#s,chunkSize))
  string.tohex_chunkSize = ( string.tohex_chunkSize and string.tohex_chunkSize == chunkSize and string.tohex_chunkSize or chunkSize )
  for i = 1,#s,chunkSize do
    rt[#rt+1] = string.format(string.tohex_sformat:sub(1,(math.min(#s-i+1,chunkSize)*4)),s:byte(i,i+chunkSize-1))
  end
  if      #rt == 1 then return rt[1]
  else    return table.concat(rt,"")
  end
end 

string.fromhex = function(str) 
  return (str:gsub('..', function (cc) return string.char(tonumber(cc, 16)) end))
end

exports('String', function(...) return string; end)