--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<Color3>

Type._name = "Color3"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return Color3.new(buffer.readf32(buf, offset), buffer.readf32(buf, offset+4), buffer.readf32(buf, offset+8)), offset + 12
end, function(self, buf: buffer, offset: number, val: Color3)
    buffer.writef32(buf, offset, val.R)
    buffer.writef32(buf, offset+4, val.G)
    buffer.writef32(buf, offset+8, val.B)
    return offset + 12
end, function(self, val: Color3)
    return 12
end, function(self, val: Color3)
    return typeof(val) == "Color3"
end)

setmetatable(Type, {
    __tostring = function(self)
        return self._name
    end
})

return function ()
    return Type :: TypeObject
end