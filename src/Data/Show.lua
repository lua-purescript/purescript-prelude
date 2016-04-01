-- module Data.Show

local exports = {}

exports.showIntImpl = function (n)
  return tostring(n)
end

exports.showNumberImpl = function (n)
  return n == math.floor(n) and n .. ".0" or tostring(n)
end

exports.showCharImpl = function (c)
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

exports.showStringImpl = function (s)
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

exports.showArrayImpl = function (f)
  return function (xs)
    local ss = {}
    for i = 1, #xs do
      ss[i] = f(xs[i])
    end
    return "[" .. table.concat(ss, ",") .. "]"
  end
end

return exports
