--!strict
local Package = script.Parent.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}

export type TypeModule = typeof(Type) & Serializer.TypeObject
export type TypeObject = Serializer.TypeObject & {enum: Enum}

Type.name = "robloxEnum"

Serializer:_registerType(Type.name, function(self: TypeObject, buf: buffer, offset: number)
    return self.enum:FromValue(buffer.readu32(buf, offset)), offset + 4
end, function(self: TypeObject, buf: buffer, offset: number, val: EnumItem)
    buffer.writeu32(buf, offset, val.Value)
    return offset + 4
end, function(self: TypeObject, val: EnumItem)
    return 4
end, function(self: TypeObject, val: EnumItem)
    return typeof(val) == "EnumItem" and val.EnumType == self.enum
end)

setmetatable(Type, {
    __call = function(self, enum: Enum)
        assert(typeof(enum) == "Enum", "An enum type must be specified")
        return {
            name = Type.name,
            enum = enum
        }
    end
})

return Type :: TypeModule