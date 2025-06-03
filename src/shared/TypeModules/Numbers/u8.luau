--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "u8"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    return buffer.readu8(buf, offset), offset + 1
end, function(self, buf: buffer, offset: number, val: number)
    buffer.writeu8(buf, offset, val)
    return offset + 1
end, function(self, val: number)
    return 1
end, function(self, val: number)
    return typeof(val) == "number" and val < 256 and val >= 0 and val % 1 == 0
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end
})

return Type :: TypeModule