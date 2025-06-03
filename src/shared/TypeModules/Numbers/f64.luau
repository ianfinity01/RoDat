--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject<number>

Type._name = "f64"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    return buffer.readf64(buf, offset), offset + 8
end, function(self, buf: buffer, offset: number, val: number)
    buffer.writef64(buf, offset, val)
    return offset + 8
end, function(self, val: number)
    return 8
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