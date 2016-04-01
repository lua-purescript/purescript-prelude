-- module Data.Semigroup

local exports = {}

exports.concatString = function (s1)
  return function (s2)
    return s1 .. s2
  end
end

exports.concatArray = function (xs)
  return function (ys)
	local result = copyTable(xs)
	for i=1, #ys do
		result[#result+1] = ys[i]
	end
    return result
  end
end

return exports
