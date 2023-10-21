--[[
FILE: com_bg_anim_option.lua
Reference Code: com_bg_anim_option.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of com_bg_anim_option.lc
when unmodified.
]] --

local value = {}

function value:initialize (sub_anim_module)
    -- Get the panes
    self.panes = get_panes(sub_anim_module, "set_parts_bg_option", "anim")
    for index, group_pane in ipairs(self.panes) do
        -- Set the position of the pane using randomly generated numbers
        local pos_x = module_ui_common.get_random() * 600 - 300
        local pos_y = module_ui_common.get_random() * 4000 - 2000
        group_pane.pane:set_position(pos_x, pos_y)

        -- Set the scale of the pane using randomly generated numbers
        local scale_x = module_ui_common.get_random() * 0.30000001192092896 + 0.10000000149011612
        local scale_y = module_ui_common.get_random() * 3 + 3
        group_pane.pane:set_scale(scale_x, scale_y)

        -- Set the alpha of the pane using a randomly generated number
        local alpha = module_ui_common.get_random() * 20 + 50
        group_pane.pane:set_alpha(alpha)
    end
    for index, group_pane in ipairs(self.panes) do
        -- Set the property of the pane
        group_pane.property =
        {
            x_sp = 0,
            y_sp = module_ui_common.get_random() + 0.10000000149011612
        }
    end
end

function value:finalize ()
end

function value:update ()
    for index, group_pane in ipairs(self.panes) do
        -- Get the X and Y positions
        local pos_x, pos_y = group_pane.pane:get_position()
        -- Set the Y position to Y + Y_SP * 20
        pos_y = pos_y + group_pane.property.y_sp * 20
        -- If Y is greater than 2000
        if 2000 < pos_y then
            -- Set Y
            pos_y = 0xFFFFFFFFFFFFF830
            -- Unused variable that I assume was meant to be the X value
            -- If I remove it the decomp is not 1-1
            local unused = module_ui_common.get_random() * 600 - 300
        end
        -- Set the position
        group_pane.pane:set_position(pos_x, pos_y)
    end
end

return value
