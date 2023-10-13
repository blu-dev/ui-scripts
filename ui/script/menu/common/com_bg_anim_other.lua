--[[
FILE: com_bg_anim_other.lua
Reference Code: com_bg_anim_other.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of com_bg_anim_other.lc
when unmodified.
]] --
local value = {}

function value:initialize (sub_anim_module)
    -- Get the panes
    self.panes = get_panes(sub_anim_module, "set_parts_bg_other", "anim")
    for index, group_pane in ipairs(self.panes) do
        -- Set the property
        group_pane.property =
        {
            max_scale = module_ui_common.get_random() * 1.83 + 0.48,
            speed_sc = module_ui_common.get_random() * 0.0363 + 0.013,
            dir_scale = 1,
            max_alpha = module_ui_common.get_random() * 30 + 50,
            anim_end = 0
        }
        if module_ui_common.get_random() <= 0.3 then
            group_pane.property.dir_scale = 0xFFFFFFFFFFFFFFFF
        end
    end
    for index, group_pane in ipairs(self.panes) do
        -- Make scale variables
        -- Side note, I do not know why they didn't use 2 separate variables
        local scale_x = module_ui_common.get_random() * 1.83 + 0.48
        local scale_y = scale_x
        -- Set the scale variables
        group_pane.pane:set_scale(scale_x, scale_y)
        -- Set the alpha
        group_pane.pane:set_alpha(module_ui_common.get_random() * 30)
        -- Create the position variables
        local pos_x = module_ui_common.get_random() * 2800 - 1400
        local pos_y = module_ui_common.get_random() * 2800 - 1400
        -- Set the position to the position variables
        group_pane.pane:set_position(pos_x, pos_y)
    end
end

function value:finalize ()
    self.panes = nil
end

function value:update ()
    for index, group_pane in ipairs(self.panes) do
        -- Get the scale from the pane
        local scale_x, scale_y = group_pane.pane:get_scale()
        -- Get the max scale property
        local max_scale = group_pane.property.max_scale
        -- Get the speed property
        local speed = group_pane.property.speed_sc
        -- Get the anim end property
        local anim_end = group_pane.property.anim_end
        -- Get the dir scale property
        local dir_scale = group_pane.property.dir_scale
        -- Get the alpha from the pane
        local alpha = group_pane.pane:get_alpha()
        -- If the animation end property = 1
        if anim_end == 1 then
            -- Set the position variables
            local pos_x = module_ui_common.get_random() * 2800 - 1400
            local pos_y = module_ui_common.get_random() * 2800 - 1400
            -- Set the pane's position
            group_pane.pane:set_position(pos_x, pos_y)

            -- If dir scale is less than 0
            if 0 < dir_scale then
                -- Set the scale variables to 0
                scale_x = 0
                scale_y = 0
                -- Set the alpha variable to a random number
                alpha = module_ui_common.get_random() * 30 + 50
            else
                -- Set the scale variables to the max scale
                scale_x = max_scale
                scale_y = max_scale
                -- Set the alpha to 0
                alpha = 0
            end
            -- Set the anim end property to 0
            group_pane.property.anim_end = 0
            -- Set the alpha to the alpha variable
            group_pane.pane:set_alpha(alpha)
            -- Set the scale to the scale variables
            group_pane.pane:set_scale(scale_x, scale_y)
        -- Thank you to jam1garner for helping me figure this one out
        else
            -- If dir scale is greater than 0
            if dir_scale > 0 then
                -- Set the x scale to
                -- X + (max scale * dir scale - X) * speed
                scale_x = scale_x + (max_scale * dir_scale - scale_x) * speed
                -- Set the y scale to
                -- Y + (max scale * dir scale - Y) * speed
                scale_y = scale_y + (max_scale * dir_scale - scale_y) * speed
                -- Set alpha using the lerp formula
                alpha = alpha + (0 - alpha) * 0.001
                -- If alpha is less than .01
                if alpha < 0.1 then
                    -- Set anim end to 1
                    group_pane.property.anim_end = 1
                end
            else
                -- Set the x scale to
                -- X + (max scale * dir scale - X) * speed
                scale_x = scale_x + (max_scale * dir_scale - scale_x) * speed * 0.22
                -- Set the Y scale to
                -- Y + (max scale * dir scale - Y) * speed
                scale_y = scale_y + (max_scale * dir_scale - scale_y) * speed * 0.22
                if scale_x < max_scale * 0.5 then
                    -- Once again use the lerp formula to set alpha
                    alpha = alpha + (0 - alpha) * 0.0007
                else
                    -- lerp
                    alpha = alpha + (group_pane.property.max_alpha - alpha) * 0.04
                end
                if scale_x < 0.02 then
                    -- Set scale
                    scale_x = 0
                    scale_y = 0
                    -- Set anim end to 1
                    group_pane.property.anim_end = 1
                end
            end

            -- NOTE: this was moved inside the else block compared to the dsluadedecompiler output
            group_pane.pane:set_scale(scale_x, scale_y)
            group_pane.pane:set_alpha(alpha)
        end
    end
end

return value