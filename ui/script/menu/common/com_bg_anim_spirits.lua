--[[
FILE: com_bg_anim_spirits.lua
Reference Code: com_bg_anim_spirits.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of com_bg_anim_spirits.lc
when unmodified.
]] --
local value = {}

function value:initialize (sub_anim_module)
    -- Get the background panes
    self.panes = get_panes(sub_anim_module, "set_parts_bg_spirits", "anim")
    -- Get the star panes
    self.star_panes = get_panes(sub_anim_module, "set_part_anim_stars", "anim")
    for index, group_pane in ipairs(self.panes) do
        -- Set the poperty for the pane
        group_pane.property =
        {
            rad = module_ui_common.get_random() * 360,
            omega = module_ui_common.get_random() / 100 + 0.0010000000474974513,
            y_sp = module_ui_common.get_random() * 4 + 1,
            r = module_ui_common.get_random() * 0.10000000149011612 + 0.9800000190734863
        }
    end
    for index, group_pane in ipairs(self.panes) do
        -- Set the pane's alpha
        group_pane.pane:set_alpha(module_ui_common.get_random() * 80 + 20)
        -- Get the position of the pane
        local pos_x, pos_y = group_pane.pane:get_position()
        -- Set the x position
        pos_x = math.sin(group_pane.property.rad) * 1920 / 3 * group_pane.property.r
        -- Set the y position
        pos_y = index * 20 - 1000

        -- Set the pane's position
        group_pane.pane:set_position(pos_x, pos_y)
        -- Set the pane's scale
        group_pane.pane:set_scale(math.cos(group_pane.property.rad) * 1.399999976158142, 1)
    end
    for index, group_pane in ipairs(self.star_panes) do
        -- Set the pane's property
        group_pane.property =
        {
            sp = module_ui_common.get_random() * 3 + 1,
            x_sc = (module_ui_common.get_random() + 1) * 0.5,
            y_sc = x_sc
        }
    end
    -- Set the count collection
    self.count_collection = 0
end

function value:finalize ()
    -- Nullify the panes and star panes on finalize
    self.panes = nil
    self.star_panes = nil
end

function value:update ()
    for index, group_pane in ipairs(self.panes) do
        -- Get the x and y positions of the pane
        local pos_x, pos_y = group_pane.pane:get_position()
        pos_x = math.sin(group_pane.property.rad) * 1920 / 3 * group_pane.property.r
        pos_y = pos_y + group_pane.property.y_sp
        -- Set the pane's rad property
        group_pane.property.rad = group_pane.property.rad + group_pane.property.omega
        -- Set the pane's scale
        group_pane.pane:set_scale(math.cos(group_pane.property.rad) * 1.399999976158142, 1)
        -- If the y position is greater than 1500
        if 1500 < pos_y then
            -- Set x and y
            pos_x = module_ui_common.get_random() * 1920 - 960
            pos_y = 0xFFFFFFFFFFFFFA24
        else
            -- Just set y
            pos_y = pos_y + group_pane.property.y_sp
        end
        -- Set the pane's position to the updated x and y values
        group_pane.pane:set_position(pos_x, pos_y)
    end
    for index, group_pane in ipairs(self.star_panes) do
        -- Create the scale variables
        local scale_x = module_ui_common.wrap(self.count_collection * 0.05000000074505806 * group_pane.property.sp, -math.pi, math.pi)
        local scale_x = math.cos(scale_x) * 0.5 + 0.5
        local scale_y = scale_x
        -- Set the scale
        group_pane.pane:set_scale(scale_x, scale_y)
        if scale_x < 0.10000000149011612 then
            -- Set the position variables, they forgot a local here
            pos_x = module_ui_common.get_random() * 1920 - 960
            pos_y = module_ui_common.get_random() * 1920 - 960
            -- Set the position to the given position variables
            group_pane.pane:set_position(pos_x, pos_y)
        end
    end
    -- Set the count collection
    self.count_collection = self.count_collection + 1
end

return value