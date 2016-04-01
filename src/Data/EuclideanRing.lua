-- module Data.EuclideanRing

local exports = {}

exports.intDegree = function (x)
  return math.abs(x)
end

exports.intDiv = function (x)
  return function (y)
    return math.floor(x / y)
  end
end

exports.intMod = function (x)
  return function (y)
    return x % y
  end
end

exports.numDiv = function (n1)
  return function (n2)
    return n1 / n2
  end
end

return exports
