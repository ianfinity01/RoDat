--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(script.Parent.Parent.Parent.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "f64"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    return buffer.readf64(buf, offset), offset + 8
end, function(self, buf: buffer, offset: number, val: number)
    buffer.writef64(buf, offset, val)
    return offset + 8
end, function(self, val: number)
    return 8
end, function(self, val: number)
    return typeof(val) == "number"
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end
})

return Type :: TypeModule