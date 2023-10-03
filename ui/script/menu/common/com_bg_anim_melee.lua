--[[
FILE: com_bg_anim_melee.lua
Reference Code: com_bg_anim_melee.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of com_bg_anim_melee.lc
when unmodified.
]] --
local value = {}

function value:initialize(sub_anim_module)
    -- Parts variable used for both panes
    local parts = sub_anim_module:get_parts("set_parts_bg_melee")
    -- Get the first pane
    self.panes_triangle_00 = get_panes(parts, "tri_emitter_00", "anim")
    -- Initialize the animation on the first pane
    self.init_anim_triangle(self.panes_triangle_00)

    -- Get the second pane
    self.panes_triangle_01 = get_panes(parts, "tri_emitter_01", "anim")
    -- Initialize the animation on the second pane
    self.init_anim_triangle(self.panes_triangle_01)
end

function value:finalize ()
    -- When finalizng, we set both panes to nil
    self.panes_triangle_00 = nil
    self.panes_triangle_01 = nil
end

function value:update ()
    -- Loop both triangle animations
    self.loop_anim_triangle(self.panes_triangle_00)
    self.loop_anim_triangle(self.panes_triangle_01)
end

function value:init_anim_triangle ()
    for index, group_pane in ipairs(self) do
        -- Set the position of the pane using randomly generated numbers
        local pos_x = module_ui_common.get_random() * 3000 - 1500
        local pos_y = module_ui_common.get_random() * 1600 - 800
        group_pane.pane:set_position(pos_x, pos_y)

        -- Set the rotation of the pane using randomly generated numbers
        local rotate_x = module_ui_common.get_random() * 360
        local rotate_y = module_ui_common.get_random() * 360
        local rotate_z = module_ui_common.get_random() * 360
        group_pane.pane:set_rotate(rotate_x, rotate_y, rotate_z)

        -- The scale (randomly generated)
        local scale = module_ui_common.get_random() * 1.5 + 0.30000001192092896
        -- Set the scale of the pane to the scale variable
        group_pane.pane:set_scale(scale, scale)

        -- Smash devs back at it again with the misspelled words
        aplha = module_ui_common.get_random() * 80 + 60
        -- Set the alpha of the pane to the alpha variable
        group_pane.pane:set_alpha(aplha)
    end
    for index, group_pane in ipairs(self) do
        -- Set the property
        group_pane.property = {
            x_sp = 6 * module_ui_common.get_random() + 1,
            y_sp = module_ui_common.get_random() + 1,
            x_rs = module_ui_common.get_random() * 0.30000001192092896,
            y_rs = module_ui_common.get_random() * 0.30000001192092896,
            z_rs = module_ui_common.get_random() * 0.30000001192092896
        }
    end
end

function value:loop_anim_triangle ()
    -- I don't know how theyre iterating over self instead of self.panes but I won't question it
    for index, group_pane in ipairs(self) do
        -- Get the pane position
        local pos_x, pos_y = group_pane.pane:get_position()
        -- If x is greater than 1500
        if 1500 < pos_x then
            -- Set X and Y
            pos_x = 0xFFFFFFFFFFFFFA24
            pos_y = module_ui_common.get_random() * 1600 - 800
        else
            -- Set X and Y
            pos_x = pos_x + group_pane.property.x_sp
            pos_y = pos_y + group_pane.property.y_sp
        end
        -- Set the pane position to updated values
        group_pane.pane:set_position(pos_x, pos_y)
        -- Get the pane's rotate
        local rotate_x, rotate_y, rotate_z = group_pane.pane:get_rotate()
        rotate_x = rotate_x + group_pane.property.x_rs
        rotate_y = rotate_y + group_pane.property.y_rs
        rotate_z = rotate_z + group_pane.property.z_rs
        -- Set the pane's rotate to updated values
        group_pane.pane:set_rotate(rotate_x, rotate_y, rotate_z)
    end
end

return value
