-- module Data.Ord

local exports = {}

exports.ordArrayImpl = function (f)
  return function (xs)
    return function (ys)
      local i = 1
      while i < #xs and i < #ys do
        local x = xs[i]
        local y = ys[i]
        local o = f(x)(y)
        if o ~= 0 then
          return o;
        end
        i = i + 1
      end
      if (#xs == #ys) then
        return 0
      elseif #xs > #ys then
        return -1
      else
        return 1
      end
    end
  end
end

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
