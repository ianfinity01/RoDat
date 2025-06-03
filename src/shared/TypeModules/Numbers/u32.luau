--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<number>

Type._name = "u32"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return buffer.readu32(buf, offset), offset + 4
end, function(self, buf: buffer, offset: number, val: number)
    buffer.writeu32(buf, offset, val)
    return offset + 4
end, function(self, val: number)
    return 4
end, function(self, val: number)
    return typeof(val) == "number" and val < 4294967296 and val >= 0 and val % 1 == 0
end)

setmetatable(Type, {
    __tostring = function(self)
        return self._name
    end
})

return function ()
    return Type :: TypeObject
end