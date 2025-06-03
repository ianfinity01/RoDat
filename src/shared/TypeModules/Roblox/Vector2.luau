--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "Vector2"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    return Vector2.new(buffer.readf32(buf, offset), buffer.readf32(buf, offset+4)), offset + 8
end, function(self, buf: buffer, offset: number, val: Vector2)
    buffer.writef32(buf, offset, val.X)
    buffer.writef32(buf, offset+4, val.Y)
    return offset + 8
end, function(self, val: Vector2)
    return 8
end, function(self, val: Vector2)
    return typeof(val) == "Vector2"
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