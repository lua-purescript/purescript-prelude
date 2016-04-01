-- module Data.Ord.Unsafe

local exports = {}

exports.unsafeCompareImpl = function (lt)
  return function (eq)
    return function (gt)
      return function (x)
        return function (y)
          return x < y and lt or (x > y and gt or eq)
	    end
      end
    end
  end
end

return exports
