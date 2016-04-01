-- module Data.Ring

local exports = {}

exports.intSub = function (x)
  return function (y)
    return math.floor(x - y)
  end
end

exports.numSub = function (n1)
  return function (n2)
    return n1 - n2
  end
end

return exports
