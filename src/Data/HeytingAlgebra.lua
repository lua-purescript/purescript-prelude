-- module Data.HeytingAlgebra

local exports = {}

exports.boolConj = function (b1)
  return function (b2)
    return b1 and b2
  end
end

exports.boolDisj = function (b1)
  return function (b2)
    return b1 or b2
  end
end

exports.boolNot = function (b)
  return not b
end

return exports
