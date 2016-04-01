-- module Data.Eq

local exports = {}

exports.refEq = function (r1)
  return function (r2)
    return r1 == r2
  end
end

exports.refIneq = function (r1)
  return function (r2)
    return r1 != r2
  end
end

exports.eqArrayImpl = function (f)
  return function (xs)
    return function (ys)
      if xs.length ~= ys.length then return false end
      for i = 1, #xs do
        if not f(xs[i])(ys[i]) then return false end
      end
      return true
    end
  end
end

return exports
