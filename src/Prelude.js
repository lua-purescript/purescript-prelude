-- module Prelude

local Prelude = {}

--- Functor --------------------------------------------------------------------

Prelude.arrayMap = function (f)
  return function (arr)
    local result = {}
    for i = 1, #arr do
      result[i] = f(arr[i]);
    end
    return result;
	end
end

--- Bind -----------------------------------------------------------------------

Prelude.arrayBind = function (arr)
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

--- Monoid ---------------------------------------------------------------------

Prelude.concatString = function (s1)
  return function (s2)
    return s1 .. s2
  end
end

Prelude.concatArray = function (xs)
  return function (ys)
	local result = copyTable(xs)
	for i=1, #ys do
		result[#result+1] = ys[i]
	end
    return result
  end
end

--- Semiring -------------------------------------------------------------------

Prelude.intAdd = function (x)
  return function (y)
    return math.floor(x + y)
  end
end

Prelude.intMul = function (x)
  return function (y)
    return math.floor(x * y)
  end
end

Prelude.numAdd = function (n1)
  return function (n2)
    return n1 + n2
  end
end

Prelude.numMul = function (n1)
  return function (n2)
    return n1 * n2
  end
end

--- ModuloSemiring -------------------------------------------------------------

Prelude.intDiv = function (x)
  return function (y)
    return math.floor(x / y)
  end
end

Prelude.intMod = function (x)
  return function (y)
    return x % y
  end
end

Prelude.numDiv = function (n1)
  return function (n2)
    return n1 / n2
  end
end

--- Ring -----------------------------------------------------------------------

Prelude.intSub = function (x)
  return function (y)
    return math.floor(x - y)
  end
end

Prelude.numSub = function (n1)
  return function (n2)
    return n1 - n2;
  end
end

--- Eq -------------------------------------------------------------------------

Prelude.refEq = function (r1)
  return function (r2)
    return r1 == r2
  end
end

Prelude.refIneq = function (r1)
  return function (r2)
    return r1 ~= r2
  end
end

Prelude.eqArrayImpl = function (f)
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

Prelude.ordArrayImpl = function (f)
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

--- Ord ------------------------------------------------------------------------

Prelude.unsafeCompareImpl = function (lt)
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

--- Bounded --------------------------------------------------------------------

Prelude.topInt = 2147483647
Prelude.bottomInt = -2147483648

Prelude.topChar = string.char(255)
Prelude.bottomChar = string.char(0)

--- BooleanAlgebra -------------------------------------------------------------

Prelude.boolOr = function (b1)
  return function (b2)
    return b1 or b2
  end
end

Prelude.boolAnd = function (b1)
  return function (b2)
    return b1 and b2
  end
end

Prelude.boolNot = function (b)
  return not b
end

--- Show -----------------------------------------------------------------------

Prelude.showIntImpl = function (n)
  return tostring(n)
end

Prelude.showNumberImpl = function (n)
  return n == math.floor(n) and n .. ".0" or tostring(n)
end

Prelude.showCharImpl = function (c)
  local code = string.byte(c)
  if code < 0x20 or code == 0x7F then
    if c == "\a" then return "'\\a'" end
    if c == "\b" then return "'\\b'" end
    if c == "\f" then return "'\\f'" end
    if c == "\n" then return "'\\n'" end
    if c == "\r" then return "'\\r'" end
    if c == "\t" then return "'\\t'" end
    if c == "\v" then return "'\\v'" end
    return "'\\" + tostring(code) + "'";
  end
  return c == "'" or c == "\\" and "'\\" + c + "'" or "'" + c + "'"
end

Prelude.showStringImpl = function (s)
  return "\"" .. string.gsub(s, "[\0-\x1F\x7F]", function(c)
      if c == "\"" or c == "\\" then
        return "\\" + c;
      end
      if c == "\a" then return "\\a" end
      if c == "\b" then return "\\b" end
      if c == "\f" then return "\\f" end
      if c == "\n" then return "\\n" end
      if c == "\r" then return "\\r" end
      if c == "\t" then return "\\t" end
      if c == "\v" then return "\\v" end
    return "\\" .. tostring(string.byte(c))
  end) .. "\""
end

Prelude.showArrayImpl = function (f)
  return function (xs)
    local ss = {}
    for i = 1, #xs do
      ss[i] = f(xs[i])
    end
    return "[" .. table.concat(ss, ",") .. "]"
  end
end

local function copyTable(tbl)
  local result = {}
  for i=1, #tbl do
    result[i] = tbl[i]
  end
  return result
end

return Prelude
