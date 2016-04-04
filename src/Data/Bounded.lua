-- module Data.Bounded

local exports = {}

exports.topInt = 2147483647
exports.bottomInt = -2147483648

exports.topChar = string.char(255)
exports.bottomChar = string.char(0)

return exports
