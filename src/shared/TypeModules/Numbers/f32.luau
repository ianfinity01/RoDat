--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject<number>

Type._name = "f32"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return buffer.readf32(buf, offset), offset + 4
end, function(self, buf: buffer, offset: number, val: number)
    buffer.writef32(buf, offset, val)
    return offset + 4
end, function(self, val: number)
    return 4
end, function(self, val: number)
    return typeof(val) == "number"
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