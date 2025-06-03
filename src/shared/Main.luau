--!strict
local Types = require(script.Parent.Types)
local Serializer = require(script.Parent.Types)

local module = {

}

module.Types = Types
module.Serializer = Serializer

Types.optional(Types.u8())
Types.CFrame()

return module