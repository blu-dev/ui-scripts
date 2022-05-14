--[[
FILE: main_menu_button.lua
Reference Code: main_menu_button.lc

Author: blujay

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of main_menu_button.lc
when unmodified.
]]--
local button = {}

local get_layer_mask = function (id, existing)
    if existing then
        local shifts = {
            0,
            8,
            16,
            24
        }
        for index, shift in ipairs(shifts) do
            if existing >> shift == 0 then
                return (id & 0xFF) << shift | existing
            end
        end
        return 0xFFFFFFFF
    end
    return id & 0xFF
end

function button:add_id (prefix, name, layer)
    local full_name = name
    if prefix then
        full_name = prefix .. "_" .. full_name
    end
    self[full_name] = get_layer_mask(layer, self[prefix])
end

function button:get_layer (id)
    local shifts = {
        8,
        16,
        24,
        32
    }

    for layer, shift in ipairs(shifts) do
        if id >> shift == 0 then
            return layer
        end
    end
    return 0
end

return button