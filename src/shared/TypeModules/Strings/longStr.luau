--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(script.Parent.Parent.Parent.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "longStr"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    local len = buffer.readu32(buf, offset)
    return buffer.readstring(buf, offset + 4, len), offset + 4 + len
end, function(self, buf: buffer, offset: number, val: string)
    local len = val:len()
    buffer.writeu32(buf, offset, len)
    buffer.writestring(buf, offset + 4, val)
    return offset + 4 + len
end, function(self, val: string)
    return 4 + val:len()
end, function(self, val: string)
    return typeof(val) == "string" and val:len() < 4294967296
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