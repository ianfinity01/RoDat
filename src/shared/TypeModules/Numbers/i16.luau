--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject<number>

Type._name = "i16"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return buffer.readi16(buf, offset), offset + 2
end, function(self, buf: buffer, offset: number, val: number)
    buffer.writei16(buf, offset, val)
    return offset + 2
end, function(self, val: number)
    return 2
end, function(self, val: number)
    return typeof(val) == "number" and val < 32768 and val >= -32768 and val % 1 == 0
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end,
    __tostring = function(self)
        return self._name
    end
})

return Type