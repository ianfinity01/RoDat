--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<Vector2>

Type._name = "Vector2"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
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
    __tostring = function(self)
        return self._name
    end
})

return function ()
    return Type :: TypeObject
end