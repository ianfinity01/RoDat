--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject<Color3>

Type._name = "lossyColor3"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return Color3.fromRGB(buffer.readi8(buf, offset), buffer.readi8(buf, offset+1), buffer.readi8(buf, offset+2)), offset + 3
end, function(self, buf: buffer, offset: number, val: Color3)
    buffer.writei8(buf, offset, math.round(val.R*255))
    buffer.writei8(buf, offset+1, math.round(val.G*255))
    buffer.writei8(buf, offset+2, math.round(val.B*255))
    return offset + 3
end, function(self, val: Color3)
    return 3
end, function(self, val: Color3)
    return typeof(val) == "Color3"
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