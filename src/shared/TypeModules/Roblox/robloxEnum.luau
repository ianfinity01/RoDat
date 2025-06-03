--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

export type TypeObject = Serializer.TypeObject<EnumItem>

local name = "robloxEnum"

Serializer:_registerType(name, function(self: TypeObject, buf: buffer, offset: number)
    return self.enum:FromValue(buffer.readu32(buf, offset)), offset + 4
end, function(self: TypeObject, buf: buffer, offset: number, val: EnumItem)
    buffer.writeu32(buf, offset, val.Value)
    return offset + 4
end, function(self: TypeObject, val: EnumItem)
    return 4
end, function(self: TypeObject, val: EnumItem)
    return typeof(val) == "EnumItem" and val.EnumType == self.enum
end)


return function(enum: Enum)
    assert(typeof(enum) == "Enum", "An enum type must be specified")
    return setmetatable({
        _name = name,
        enum = enum
    }, {
        __tostring = function(obj: TypeObject)
            return `{obj._name}(Enum.{obj.enum})`
        end
    }) :: TypeObject
end