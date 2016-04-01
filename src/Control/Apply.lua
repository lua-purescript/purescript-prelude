-- module Control.Apply

local exports = {}

exports.arrayApply = function (fs)
  return function (xs)
    local result = {}
    local n = 1
    for i = 1, #fs do
      for j = 1, #xs do
        result[n] = fs[i](xs[j])
        n = n + 1
      end
	end
    return result
  end
end

return exports
