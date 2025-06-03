--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)
local smartUInt = require(Package.Numbers.smartUInt)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject

Type.name = "dynamicStr"

Serializer:_registerType(Type.name, function(self, buf: buffer, offset: number)
    local len, offset = Serializer:Read(smartUInt, buf, offset)
    return buffer.readstring(buf, offset + 4, len), offset + 4 + len -- TODO: FINISH
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