--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "Vector3"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    return Vector3.new(buffer.readf32(buf, offset), buffer.readf32(buf, offset+4), buffer.readf32(buf, offset+8)), offset + 12
end, function(self, buf: buffer, offset: number, val: Vector3)
    buffer.writef32(buf, offset, val.X)
    buffer.writef32(buf, offset+4, val.Y)
    buffer.writef32(buf, offset+8, val.Z)
    return offset + 12
end, function(self, val: Vector3)
    return 12
end, function(self, val: Vector3)
    return typeof(val) == "Vector3"
end)

setmetatable(Type, {
    __call = function(self)
        return self
    end
})

return Type :: TypeModule