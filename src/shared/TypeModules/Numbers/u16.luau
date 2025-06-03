--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "u16"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    return buffer.readu16(buf, offset), offset + 2
end, function(self, buf: buffer, offset: number, val: number)
    buffer.writeu16(buf, offset, val)
    return offset + 2
end, function(self, val: number)
    return 2
end, function(self, val: number)
    return typeof(val) == "number" and val < 65536 and val >= 0 and val % 1 == 0
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end,
    __tostring = function(self)
        return self.name
    end
})

return Type :: TypeModule