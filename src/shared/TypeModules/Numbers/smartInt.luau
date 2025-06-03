--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "smartInt"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    local len = 0
    local result = 0
    local sign = false
    local num = buffer.readu8(buf, offset)
    local res = num % 128
    if res >= 64 then
        sign = true
    end
    result += res % 64
    len += 1
    while num >= 128 do
        num = buffer.readu8(buf, offset + len)
        result += (num%128)*2^(7*len - 1)
        len += 1
    end
    return sign and -result or result, offset + len
end, function(self, buf: buffer, offset: number, val: number)
    local len = 0
    local num = val < 0 and 64 or 0
    val = math.abs(val)
    if val >= 64 then
        num += 128
    end
    num += val % 64
    val = math.floor(val/64)
    buffer.writeu8(buf, offset, num)
    len += 1
    while true do
        num = val >= 128 and 128 or 0
        num += val % 128
        val = math.floor(val/128)
        buffer.writeu8(buf, offset + len, num)
        len += 1
        if val == 0 then
            break
        end
    end
    return offset + len
end, function(self, val: number)
    if val == 0 then
        return 1
    end
    return math.floor((math.log(math.abs(val), 2) + 1)/7) + 1
end, function(self, val: number)
    return typeof(val) == "number" and val % 1 == 0
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end
})

return Type :: TypeModule