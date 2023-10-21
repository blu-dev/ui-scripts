--[[
FILE: com_bg_anim_local.lua
Reference Code: com_bg_anim_local.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of com_bg_anim_local.lc
when unmodified.
]] --
local value = {}
function value:initialize (sub_anim_module)
    -- Get the panes
    self.panes = get_panes(sub_anim_module, "set_parts_bg_local", "anim")
    for index, group_pane in ipairs(self.panes) do
        -- Create variables for the pane's rotate, and set the pane's rotate
        local rotate_x = module_ui_common.get_random() * 360
        local rotate_y = module_ui_common.get_random() * 360
        local rotate_z = module_ui_common.get_random() * 360
        group_pane.pane:set_rotate(rotate_x, rotate_y, rotate_z)

        -- Create a variable for the pane's scale, and set the pane's scale
        local scale = module_ui_common.get_random() * 1.5 + 0.30000001192092896
        group_pane.pane:set_scale(scale, scale)
    end
    for index, group_pane in ipairs(self.panes) do
        -- Set the property
        group_pane.property = {
            x_sp = 7 * module_ui_common.get_random() + 2,
            y_sp = module_ui_common.get_random() + 1,
            z_rs = module_ui_common.get_random() * 0.5
        }
    end
end

function value:finalize ()
    self.panes = nil
end

function value:update ()
    for index, group_pane in ipairs(self.panes) do
        -- Get the pane's position
        local pos_x, pos_y = group_pane.pane:get_position()
        -- If x is greater than 1600
        if 1600 < pos_x then
            -- Set x and y to updated values
            pos_x = 0xFFFFFFFFFFFFF9C0
            pos_y = module_ui_common.get_random() * 3000 - 1500
        else
            -- Set x and y to updated values
            pos_x = pos_x + group_pane.property.x_sp
            pos_y = pos_y + group_pane.property.y_sp
        end
        -- Set the pane's position
        group_pane.pane:set_position(pos_x, pos_y)

        -- Get the pane's rotate variables
        local rotate_x, rotate_y, rotate_z = group_pane.pane:get_rotate()
        -- Update the z rotate value
        rotate_z = rotate_z + group_pane.property.z_rs

        -- Set the pane's rotate
        group_pane.pane:set_rotate(rotate_x, rotate_y, rotate_z)
    end
end

return value