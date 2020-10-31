table.copy = function(t,_s)
  local r = {}
  local s = (_s or {})
  for k,v in pairs(t) do
    if type(v) == "table" then
      if not s[v] then
        s[v] = true
        r[k] = table.copy(v,s)
      end
    else
      r[k] = v
    end
  end
  return r
end

table.tovec = function(t)
  if t.w then
    return vector4(t.x,t.y,t.z,t.w)
  elseif t.z then
    return vector3(t.x,t.y,t.z)
  elseif t.y then
    return vector2(t.x,t.y)
  end
end

table.fromvec = function(v)
  local t = type(v)
  if t == "vector4" then
    return {x = v.x,y = v.y, z = v.z, w = v.w}
  elseif t == "vector3" then
    return {x = v.x,y = v.y, z = v.z}
  elseif t == "vector2" then
    return {x = v.x,y = v.y}
  end
end