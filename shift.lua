local data = {
}

local oldStart = 52.375615
local newStart = 165.809769

local diff = newStart - oldStart

for _, time in ipairs(data) do
    print(tostring(time + diff) .. ",")
end
