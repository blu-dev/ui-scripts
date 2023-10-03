--[[
FILE: com_bg_anim.lua
Reference Code: com_bg_anim.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of com_bg_anim.lc
when unmodified.
]]--
local bg_anim = {}

-- not local because all of the other com_bg_anim files use it
module_ui_common = UiScriptPlayer.require("common/ui_common")

-- Decided it would be better to keep the naming scheme
local module_bg_anim_melee = UiScriptPlayer.require("menu/common/com_bg_anim_melee")
local module_bg_anim_spirits = UiScriptPlayer.require("menu/common/com_bg_anim_spirits")
local module_bg_anim_other = UiScriptPlayer.require("menu/common/com_bg_anim_other")
local module_bg_anim_collection = UiScriptPlayer.require("menu/common/com_bg_anim_collection")
local module_bg_anim_online = UiScriptPlayer.require("menu/common/com_bg_anim_online")
local module_bg_anim_local = UiScriptPlayer.require("menu/common/com_bg_anim_local")
local module_bg_anim_option = UiScriptPlayer.require("menu/common/com_bg_anim_option")
local module_bg_anim_help = UiScriptPlayer.require("menu/common/com_bg_anim_help")
local module_bg_anim_eshop = UiScriptPlayer.require("menu/common/com_bg_anim_eshop")

-- We add all of the previously imported modules into bg_anim.modules
bg_anim.modules =
{
    module_bg_anim_melee,
    module_bg_anim_spirits,
    module_bg_anim_other,
    module_bg_anim_collection,
    module_bg_anim_online,
    module_bg_anim_local,
    module_bg_anim_option,
    module_bg_anim_help,
    module_bg_anim_eshop
}

-- Globals used for quick access to anim module indexes
ANIM_MODULE_MELEE = 1
ANIM_MODULE_SPIRITS = 2
ANIM_MODULE_OTHER = 3
ANIM_MODULE_COLLECTION = 4
ANIM_MODULE_ONLINE = 5
ANIM_MODULE_LOCAL = 6
ANIM_MODULE_OPTION = 7
ANIM_MODULE_HELP = 8
ANIM_MODULE_ESHOP = 9

function bg_anim:initialize(sub_anim_module, module_index)
    -- Check if module_index exists
    if self.modules[module_index] then
        -- If it does, initialize it and provide the sub_anim_module
        self.modules[module_index]:initialize(sub_anim_module)
    end
end

function bg_anim:finalize(module_index)
    -- Check if module_index exists
    if self.modules[module_index] then
        -- If it does, finalize the module
        self.modules[module_index]:finalize()
    end
end

function bg_anim:update(module_index)
    -- Check if module_index exists
    if self.modules[module_index] then
        -- If it does, update the module
        self.modules[module_index]:update()
    end
end

get_panes = function(anim_module, part_id, group_id)
    -- The variable we use to store the panes, and what we return
    local panes = {}
    -- Get the parts from the anim_module and part_id
    local parts = anim_module:get_parts(part_id)
    -- Get the group panes from the parts and the group_id
    local group_panes = parts:get_group_panes(group_id)
    -- Iterate over the panes, using ipairs to get an index
    for pane_index, pane in ipairs(group_panes) do
        -- Set the current pane_index to a dictionary of pane and property
        panes[pane_index] = {
            pane = pane,
            property = {}
        }
    end
    -- I didn't know lua had a print system, but we print "[part]: [{}, ]" here
    print_log("[" .. part_id .. "] : " .. #panes)
    -- Return panes
    return panes
end

return bg_anim
