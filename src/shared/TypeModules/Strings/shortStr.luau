--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject<string>

Type._name = "shortStr"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
    local len = buffer.readu8(buf, offset)
    return buffer.readstring(buf, offset + 1, len), offset + 1 + len
end, function(self, buf: buffer, offset: number, val: string)
    local len = val:len()
    buffer.writeu8(buf, offset, len)
    buffer.writestring(buf, offset + 1, val)
    return offset + 1 + len
end, function(self, val: string)
    return 1 + val:len()
end, function(self, val: string)
    return typeof(val) == "string" and val:len() < 256
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