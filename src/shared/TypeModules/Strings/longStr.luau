--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeObject = Serializer.TypeObject<string>

Type._name = "longStr"

Serializer:_registerType(Type._name, function(self, buf: buffer, offset: number)
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
    __tostring = function(self)
        return self._name
    end
})

return function ()
    return Type :: TypeObject
end