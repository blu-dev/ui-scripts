--[[
FILE: com_bg_anim_help.lua
Reference Code: com_bg_anim_help.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of com_bg_anim_help.lc
when unmodified.
]] --
local value = {}

function value:initialize (sub_anim_module)
    -- Get the panes
    self.panes = get_panes(sub_anim_module, "set_parts_bg_help", "anim")
    for index, group_pane in ipairs(self.panes) do
        -- Create position variables and then set the pane's position
        local pos_x = module_ui_common.get_random() * 600 - 300
        local pos_y = module_ui_common.get_random() * 4000 - 2000
        group_pane.pane:set_position(pos_x, pos_y)

        -- Create scale variables and then set the pane's scale
        local scale_x = module_ui_common.get_random() * 0.30000001192092896 + 0.10000000149011612
        local scale_y = module_ui_common.get_random() * 3 + 3
        group_pane.pane:set_scale(scale_x, scale_y)

        -- Create the alpha variable and set the pane's alpha
        local alpha = module_ui_common.get_random() * 20 + 50
        group_pane.pane:set_alpha(alpha)
    end
    for index, group_pane in ipairs(self.panes) do
        -- Set the property
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
        -- Get the current position of the pane
        local pos_x, pos_y = group_pane.pane:get_position()
        -- Set the y position to an updated value
        pos_y = pos_y + group_pane.property.y_sp * 20

        -- if y is greater than 2000
        if 2000 < pos_y then
            -- Set the y position
            pos_y = 0xFFFFFFFFFFFFF830
            -- Unused variable strikes again
            local unused = module_ui_common.get_random() * 600 - 300
        end

        -- Set the positions of the pane
        group_pane.pane:set_position(pos_x, pos_y)
    end
end

return value