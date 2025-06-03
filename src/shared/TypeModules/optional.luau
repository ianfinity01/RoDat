--!strict
local Package = script.Parent.Parent
local Serializer = require(Package.Serializer)

local Type = {}
local name = "optional"

export type TypeModule = typeof(Type)
export type TypeObject<T> = Serializer.TypeObject<T?> & {type: Serializer.TypeObject<T>}

Serializer:_registerType(name, function<T>(self: TypeObject<T>, buf: buffer, offset: number): (T?, number)
    if buffer.readu8(buf, offset) == 1 then
        return nil, offset + 1
    end
    return Serializer:Read(self.type, buf, offset + 1)
end, function<T>(self: TypeObject<T>, buf: buffer, offset: number, val: T?): number
    if val == nil then
        buffer.writeu8(buf, offset, 1)
        return offset + 1
    end
    buffer.writeu8(buf, offset, 0)
    return Serializer:Write(self.type, val, buf, offset + 1)
end, function<T>(self: TypeObject<T>, val: T?): number
    if val == nil then
        return 1
    end
    return 1 + Serializer:Length(self.type, val)
end, function<T>(self: TypeObject<T>, val: T?): boolean
    return val == nil or Serializer:Validate(self.type, val)
end)

setmetatable(Type, {
    __call = function<T>(self, otherType: Serializer.TypeObject<T>)
        assert(typeof(otherType) == "table" and otherType.name, "An type must be specified for the optional")
        return setmetatable({
            _name = name,
            type = otherType
        }, {
            __tostring = function(obj: TypeObject<T>)
                return `{obj._name}({obj.type})`
            end
        })
    end
})

return Type