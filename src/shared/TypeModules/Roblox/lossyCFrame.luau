--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<CFrame>

Type._name = "lossyCFrame"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return CFrame.new(
        buffer.readf32(buf, offset),
        buffer.readf32(buf, offset+4),
        buffer.readf32(buf, offset+8)
    )*CFrame.fromOrientation(
        buffer.readf32(buf, offset+12),
        buffer.readf32(buf, offset+16),
        buffer.readf32(buf, offset+20)
    ), offset + 24
end, function(self, buf: buffer, offset: number, val: CFrame)
    local pos, ry, rx, rz = val.Position, val:ToOrientation()
    buffer.writef32(buf, offset, pos.X)
    buffer.writef32(buf, offset+4, pos.Y)
    buffer.writef32(buf, offset+8, pos.Z)
    buffer.writef32(buf, offset+12, rx)
    buffer.writef32(buf, offset+16, ry)
    buffer.writef32(buf, offset+20, rz)
    return offset + 24
end, function(self, val: CFrame)
    return 24
end, function(self, val: CFrame)
    return typeof(val) == "CFrame"
end)

setmetatable(Type, {
    __tostring = function(self)
        return self._name
    end
})

return function ()
    return Type :: TypeObject
end