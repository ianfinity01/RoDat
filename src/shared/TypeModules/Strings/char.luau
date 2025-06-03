--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "char"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    return string.char(buffer.readu8(buf, offset)), offset + 1
end, function(self, buf: buffer, offset: number, val: string)
    buffer.writeu8(buf, offset, string.byte(val))
    return offset + 1
end, function(self, val: string)
    return 1
end, function(self, val: string)
    return typeof(val) == "string" and val:len() == 1
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