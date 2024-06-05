---@class PrizKeySpec
---@field lhs string Left hand side; Motion key
---@field rhs string | function Right hand side; Execution
---@field desc string Description
---@field mode? string | string[] Vim mode
---@field noremap? boolean default: true
---@field silent? boolean default: true


---@class PrizWhichkeySpec
---@field [string] string bind:description


---@class PrizKeymapSpec
---@field whichkeys PrizWhichkeySpec
local M = {
    whichkeys = {},
}


---@param specs PrizKeySpec[]
---@return LazyKeysSpec[]
function M.lazy(specs)
    local lazyspec = {} ---@type LazyKeysSpec[]

    for _, spec in ipairs(specs) do
        lazyspec[#lazyspec + 1] = {
            spec.lhs,
            spec.rhs,
            mode = spec.mode or "n",
            desc = spec.desc,
            noremap = spec.noremap ~= nil and spec.noremap or true,
            silent = spec.silent ~= nil and spec.silent or true,
        }
    end

    return lazyspec
end

return M
