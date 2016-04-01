-- module Data.Semiring

exports.intAdd = function (x)
  return function (y)
    return math.floor(x + y)
  end
end

exports.intMul = function (x)
  return function (y)
    return math.floor(x * y)
  end
end

exports.numAdd = function (n1)
  return function (n2)
    return n1 + n2
  end
end

exports.numMul = function (n1)
  return function (n2)
    return n1 * n2
  end
end
