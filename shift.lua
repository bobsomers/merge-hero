local data = {
}

local oldStart = 52.375615
local newStart = 104.717197

local diff = newStart - oldStart

for _, time in ipairs(data) do
    print(tostring(time + diff) .. ",")
end
