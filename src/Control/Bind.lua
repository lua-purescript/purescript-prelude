-- module Control.Bind

local exports = {}

exports.arrayBind = function (arr)
  return function (f)
    local result = {}
    for i = 1, #arr do
	  local inner = f(arr[i])
      for j = 1, #inner do
		result[#result+1] = inner[j]
	  end
	end
    return result;
  end
end

return exports
