--!strict
local Serializer = {}
Serializer.types = {} :: {string: Type<any>}

export type Serializer = typeof(Serializer)
export type Type<T> = {
    Read: Read<T>,
    Write: Write<T>,
    Length: Length<T>,
    Validate: Validate<T>
}
export type TypeObject = typeof(setmetatable({}::{name:string,[any]:any}, {}::any))
type Read<T> = (TypeObject, buffer, number) -> (T, number) -- typeObj, buffer, offset -> read value, new offset
type Write<T> = (TypeObject, buffer, number, T) -> (number) -- typeObj, buffer, offset, value -> new offset
type Length<T> = (TypeObject, T) -> (number) -- typeObj, value -> length of value when serialized
type Validate<T> = (TypeObject, T) -> (boolean) -- typeObj, value -> whether the value is valid for the type

--[[
Registers a new type with a specific name.
Takes in a Read, Write, Length, and Validate function for that type
]]
function Serializer._registerType<T>(self: Serializer, name: string, read: Read<T>, write: Write<T>, length: Length<T>, validate: Validate<T>)
    self.types[name] = {
        Read = read,
        Write = write,
        Length = length,
        Validate = validate
    } :: Type<T>
end

--[[
Reads a serialized type from a buffer with the given read offset and type
Returns the read value and a new read offset
Errors if the type name is invalid or reading fails
]]
function Serializer.Read<T>(self: Serializer, Type: TypeObject, buf: buffer, offset: number?): (T, number)
    local t = self.types[Type.name] :: Type<T>
    assert(t, `Invalid type for read '{Type.name}'.`)
    return t.Read(Type, buf, offset or 0)
end

--[[
Writes a serialized type to a buffer with the given value, read offset, and type
Returns a new read offset
Errors if the type name is invalid or writing fails
]]
function Serializer.Write<T>(self: Serializer, Type: TypeObject, val: T, buf: buffer, offset: number?): (number)
    local t = self.types[Type.name] :: Type<T>
    assert(t, `Invalid type for write '{Type.name}'.`)
    return t.Write(Type, buf, offset or 0, val)
end

--[[
Determines the length of a value of a specific type when serialzed
Returns the length in bytes
]]
function Serializer.Length<T>(self: Serializer, Type: TypeObject, val: T): (number)
    local t = self.types[Type.name] :: Type<T>
    assert(t, `Invalid type for length '{Type.name}'.`)
    return t.Length(Type, val)
end

--[[
Determines whether the passed value can be serialized into the specified type
Returns a boolean of whether or not it is valid
]]
function Serializer.Validate<T>(self: Serializer, Type: TypeObject, val: T): (boolean)
    local t = self.types[Type.name] :: Type<T>
    assert(t, `Invalid type for validate '{Type.name}'.`)
    return t.Validate(Type, val)
end

return Serializer :: Serializer