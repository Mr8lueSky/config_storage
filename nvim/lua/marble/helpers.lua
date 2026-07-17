---@param orig table
---@param new table
function MERGE_TABLES(orig, new)
    for key, value in pairs(new) do
        if type(value) == 'table' and orig[key] ~= nil then
            MERGE_TABLES(orig[key], value)
        else
            orig[key] = value
        end
    end
    return orig
end
