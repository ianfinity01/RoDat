--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<number>

Type._name = "smartUInt"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    local len = 0
    local result = 0
    while true do
        local num = buffer.readu8(buf, offset + len)
        result += (num%128)*2^(7*len)
        len += 1
        if num < 128 then
            break
        end
    end
    return result, offset + len
end, function(self, buf: buffer, offset: number, val: number)
    local len = 0
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
    return math.floor((math.log(math.abs(val), 2))/7) + 1
end, function(self, val: number)
    return typeof(val) == "number" and val % 1 == 0 and val > 0
end)

setmetatable(Type, {
    __tostring = function(self)
        return self._name
    end
})

return function ()
    return Type :: TypeObject
end