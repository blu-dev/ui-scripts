--[[
FILE: com_bg_anim_collection.lua
Reference Code: com_bg_anim_collection.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of com_bg_anim_collection.lc
when unmodified.
]] --

local value = {}
function value:initialize (sub_anim_module)
    -- Set the pane
    self.circle_panes_01 = get_panes(sub_anim_module, "set_parts_bg_colle", "anim_01")
    -- Initialize the anim
    self:init_anim_01()
end

function value:finalize ()
    -- When finalizing, set the pane to nothing
    self.circle_panes_01 = nil
end

function value:update ()
    -- Update the animation
    self:anim_update_01()
end

function value:init_anim_01 ()
    for index, circle_pane in ipairs(self.circle_panes_01) do
        -- Set the x position to 0
        local pos_x = 0
        -- Set the y position to a randomly generated number
        local pos_y = module_ui_common.get_random() * 1200 - 600
        -- If y is less than 150
        if math.abs(pos_y) < 150 then
            -- no clue
            local y_2 = 150
            -- If y is less than 0
            if pos_y < 0 then
                y_2 = 0xFFFFFFFFFFFFFF6A
            end
            -- Set the y value to the updated value
            pos_y = pos_y + y_2
        end

        -- Set the pane's position
        circle_pane.pane:set_position(pos_x, pos_y)
        -- Set the pane's alpha
        circle_pane.pane:set_alpha(module_ui_common.get_random() * 40 + 120)

        -- Create a scale_y variable and set the pane's scale
        local scale_y = module_ui_common.get_random() * 8 + 1
        circle_pane.pane:set_scale(100, scale_y)

        -- Set the pane's rotate
        circle_pane.pane:set_rotate(90, 0, 30)

        -- Create the z position variable, and then set the pane's z position
        local pos_z = module_ui_common.get_random() * 20000 - 3000
        circle_pane.pane:set_position_z(pos_z)
    end
    for index, circle_pane in ipairs(self.circle_panes_01) do
        -- Set the property
        circle_pane.property = {
            x_sp = 0,
            y_sp = 0,
            z_sp = module_ui_common.get_random() * 0.004900000058114529 + 0.0031999999191612005,
            alpha = module_ui_common.get_random() * 40 + 120
        }
    end
end

function value:anim_update_01 ()
    for index, circle_pane in ipairs(self.circle_panes_01) do
        -- Get the current position of the pane
        local pos_x, pos_y = circle_pane.pane:get_position()
        local pos_z = circle_pane.pane:get_position_z()

        -- Set the z position
        pos_z = pos_z + (13000 - pos_z) * circle_pane.property.z_sp

        -- Create the alpha variable and set the pane's alpha
        local alpha = circle_pane.pane:get_alpha()
        alpha = alpha + (circle_pane.property.alpha - alpha) * circle_pane.property.z_sp * 4
        circle_pane.pane:set_alpha(alpha)

        -- If the z position is greater than 11000
        if 11000 < pos_z then
            -- Set the z positoon to a randomly generated number
            pos_z = 0xFFFFFFFFFFFFDCD8 + module_ui_common.get_random() * 1000
            -- Set the x position to 0
            pos_x = 0
            -- Set the y position to a randomly generated number
            pos_y = module_ui_common.get_random() * 1200 - 600
            -- If y is less than 150
            if math.abs(pos_y) < 150 then
                -- i still dont know
                local y_2 = 150
                -- If y is less than 0
                if pos_y < 0 then
                    y_2 = 0xFFFFFFFFFFFFFF6A
                end
                -- Set y to the updated value
                pos_y = pos_y + y_2
            end
            -- Set the pane's alpha to 0
            circle_pane.pane:set_alpha(0)
        end
        -- Set the pane's position to the updated values
        circle_pane.pane:set_position(pos_x, pos_y)
        circle_pane.pane:set_position_z(pos_z)
    end
end

function value:map (in_min, in_max, out_min, out_max)
    -- The gist of this formula was taken from https://arduino.stackexchange.com/questions/32148/explanation-of-the-formula-of-the-map-funtion, modified to produce a 1 to 1 output with the base game
    return  out_min + (out_max - out_min) * ((self - in_min) / (in_max - in_min))
end

return value