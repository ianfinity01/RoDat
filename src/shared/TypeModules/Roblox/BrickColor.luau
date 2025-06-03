--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "BrickColor"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    return BrickColor.new(buffer.readu16(buf, offset)), offset + 2
end, function(self, buf: buffer, offset: number, val: BrickColor)
    buffer.writeu16(buf, offset, val.Number)
    return offset + 2
end, function(self, val: BrickColor)
    return 2
end, function(self, val: BrickColor)
    return typeof(val) == "BrickColor"
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