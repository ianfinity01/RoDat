--!strict
local Compound = {}
Compound.__index = Compound

export type Class = typeof(setmetatable({}::{

}, Compound))

function Compound.new()
    
end

function Compound._init(self: Class)

end

return Compound