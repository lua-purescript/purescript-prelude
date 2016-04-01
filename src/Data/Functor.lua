-- module Data.Functor

local exports = {}

exports.arrayMap = function (f)
  return function (arr)
    local result = {}
    for i = 1, #arr do
      result[i] = f(arr[i])
    end
    return result
	end
end

return exports
