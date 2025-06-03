--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<UDim>

Type._name = "UDim"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return UDim.new(buffer.readf32(buf, offset), buffer.readi32(buf, offset+4)), offset + 8
end, function(self, buf: buffer, offset: number, val: UDim)
    buffer.writef32(buf, offset, val.Scale)
    buffer.writei32(buf, offset+4, val.Offset)
    return offset + 8
end, function(self, val: UDim)
    return 8
end, function(self, val: UDim)
    return typeof(val) == "UDim"
end)

setmetatable(Type, {
    __tostring = function(self)
        return self._name
    end
})

return function ()
    return Type :: TypeObject
end