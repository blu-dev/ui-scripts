--[[
FILE: com_bg_actor.lua
Reference Code: com_bg_actor.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of com_bg_actor.lc
when unmodified.
]] --
local bg_anim_module = UiScriptPlayer.require("menu/common/com_bg_anim")

initialize = function (module_index)
    -- Get the root view
    local root_view = layout_root:get_root_view()
    -- Initialize the background animation
    bg_anim_module:initialize(root_view, module_index)
end

finalize = function (module_index)
    -- Finalize the background animation
    bg_anim_module:finalize(module_index)
end

update = function (module_index)
    -- Update the background animation
    bg_anim_module:update(module_index)
end
