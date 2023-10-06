--[[
FILE: com_bg_anim_online.lua
Reference Code: com_bg_anim_online.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of com_bg_anim_online.lc
when unmodified.
]] --
local value = {}
function value:initialize (sub_anim_module)
    self.panes = get_panes(sub_anim_module, "set_parts_bg_online", "anim")
    for index, group_pane in ipairs(self.panes) do
        -- Set the pane's property
        group_pane.property =
        {
            sx = 0,
            sy = 0,
            scx = 0,
            scy = 0,
            alpha = (module_ui_common.get_random() * 0.30000001192092896 + 0.10000000149011612) * 255,
            r = module_ui_common.get_random() * 50 + 500,
            rad = 0,
            omega = 0.004000000189989805 * (module_ui_common.get_random() + 0.5) * (index % 2 * 2 - 1),
            ro = index * 40,
            rr = 2048
        }
        -- If index is greater than or equal to 0, and if index is less than 5
        if 0 <= index and index < 5 then
            -- Set sx
            group_pane.property.sx = 0xFFFFFFFFFFFFFB50 + module_ui_common.get_random() * 120
            -- Set sy
            group_pane.property.sy = 1900 + module_ui_common.get_random() * 120
            -- Set scx
            group_pane.property.scx = 1.100000023841858 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.019999999552965164
            -- Set scy
            group_pane.property.scy = 1.100000023841858 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.019999999552965164
        end
        -- If index is greater than or equal to 5, and if index is less than 10
        if 5 <= index and index < 10 then
            -- Set sx
            group_pane.property.sx = 0xFFFFFFFFFFFFF9C0 + module_ui_common.get_random() * 120
            -- Set sy
            group_pane.property.sy = 2300 + module_ui_common.get_random() * 120
            -- Set scx
            group_pane.property.scx = 1.2000000476837158 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.019999999552965164
            -- Set scy
            group_pane.property.scy = 1.2000000476837158 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.019999999552965164
        end
        -- If index is greater than or equal to 10, and if index is less than 15
        if 10 <= index and index < 15 then
            -- Set sx
            group_pane.property.sx = 900 + module_ui_common.get_random() * 120
            -- Set sy
            group_pane.property.sy = 0xFFFFFFFFFFFFF9C0 + module_ui_common.get_random() * 120
            -- Set scx
            group_pane.property.scx = 0.8999999761581421 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.029999999329447746
            -- Set scy
            group_pane.property.scy = 0.8999999761581421 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.029999999329447746
            -- Set alpha
            group_pane.property.alpha = (module_ui_common.get_random() * 0.20000000298023224 + 0.20000000298023224) * 255
        end
        -- If index is greater than or equal to 15, and if index is less than 20
        if 15 <= index and index < 20 then
            -- Set sx
            group_pane.property.sx = 600 + module_ui_common.get_random() * 120
            -- Set sy
            group_pane.property.sy = 0xFFFFFFFFFFFFFB50 + module_ui_common.get_random() * 120
            -- Set scx
            group_pane.property.scx = 0.8999999761581421 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.009999999776482582
            -- Set scy
            group_pane.property.scy = 0.8999999761581421 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.009999999776482582
            -- Set alpha
            group_pane.property.alpha = (module_ui_common.get_random() * 0.20000000298023224 + 0.20000000298023224) * 255
        end
        -- If index is greater than or equal to 20, and if index is less than 25
        if 20 <= index and index < 25 then
            -- Set sx
            group_pane.property.sx = 1200 + module_ui_common.get_random() * 120
            -- Set sy
            group_pane.property.sy = 0xFFFFFFFFFFFFFBB4 + module_ui_common.get_random() * 120
            -- Set scx
            group_pane.property.scx = 0.800000011920929 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.03999999910593033
            -- Set scy
            group_pane.property.scy = 0.800000011920929 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.03999999910593033
        end
        -- If index is greater than or equal to 25, and if index is less than 30
        if 25 <= index and index < 30 then
            -- Set sx
            group_pane.property.sx = 200 + module_ui_common.get_random() * 120
            -- Set sy
            group_pane.property.sy = 1100 + module_ui_common.get_random() * 120
            -- Set scx
            group_pane.property.scx = 0.6000000238418579 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.03999999910593033
            -- Set scy
            group_pane.property.scy = 0.6000000238418579 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.03999999910593033
        end
        -- If index is greater than or equal to 30, and if index is less than 35
        if 30 <= index and index < 35 then
            -- Set sx
            group_pane.property.sx = 400 + module_ui_common.get_random() * 120
            -- Set sy
            group_pane.property.sy = 1800 + module_ui_common.get_random() * 120
            -- Set scx
            group_pane.property.scx = 1 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.019999999552965164
            -- Set scy
            group_pane.property.scy = 1 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.019999999552965164
        end
        -- If index is greater than or equal to 35
        if 35 <= index then
            -- Set sx
            group_pane.property.sx = 800 + module_ui_common.get_random() * 120
            -- Set sy
            group_pane.property.sy = 2600 + module_ui_common.get_random() * 120
            -- Set scx
            group_pane.property.scx = 1.2000000476837158 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.019999999552965164
            -- Set scy
            group_pane.property.scy = 1.2000000476837158 * (index % 2 * 2 - 1) + module_ui_common.get_random() * 0.019999999552965164
        end
    end
    for index, group_pane in ipairs(self.panes) do
        -- Set the pane's alpha
        group_pane.pane:set_alpha(group_pane.property.alpha)
        -- Set the ro propertu
        group_pane.property.ro = group_pane.property.ro + math.sin(group_pane.property.rad) * math.sin(group_pane.property.rad) + 1.2000000476837158 * (index % 2 * 2 - 1)

        -- Scale and position variables
        local scale_x = group_pane.property.scx + math.sin(group_pane.property.rad) * 0.019999999552965164
        local scale_y = group_pane.property.scy + math.cos(group_pane.property.rad) * 0.019999999552965164
        local pos_x = group_pane.property.sx + group_pane.property.r * math.cos(group_pane.property.rad * math.pi / 2) + group_pane.property.rr / 2 * math.cos((group_pane.property.ro - 90) * math.pi / 180) * scale_x
        local pos_y = group_pane.property.sy + group_pane.property.r * math.sin(group_pane.property.rad * math.pi / 2) + group_pane.property.rr / 2 * math.sin((group_pane.property.ro - 90) * math.pi / 180) * scale_y

        -- Set the pane's rotate
        group_pane.pane:set_rotate(0, 0, group_pane.property.ro)
        -- Set the pane's position
        group_pane.pane:set_position(pos_x, pos_y)
        -- Set the pane's scale
        group_pane.pane:set_scale(scale_x, scale_y)
    end
end

function value:finalize ()
    self.panes = nil
end

function value:update ()
    for f3_local5, group_pane in ipairs(self.panes) do
        -- Set the rad property
        group_pane.property.rad = group_pane.property.rad + group_pane.property.omega
        group_pane.property.rad = module_ui_common.wrap(group_pane.property.rad, -math.pi, math.pi)

        -- Set the ro property
        group_pane.property.ro = group_pane.property.ro + math.sin(group_pane.property.rad) * math.sin(group_pane.property.rad) + 1.2000000476837158 * (f3_local5 % 2 * 2 - 1)
        group_pane.property.ro = module_ui_common.wrap(group_pane.property.ro, 0xFFFFFFFFFFFFFE98, 360)

        -- Scale and Position variables
        local scale_x = group_pane.property.scx + math.sin(group_pane.property.rad) * 0.019999999552965164
        local scale_y = group_pane.property.scy + math.cos(group_pane.property.rad) * 0.019999999552965164
        local pos_x = group_pane.property.sx + group_pane.property.r * math.cos(group_pane.property.rad * math.pi / 2) + group_pane.property.rr / 2 * math.cos((group_pane.property.ro - 90) * math.pi / 180) * scale_x
        local pos_y = group_pane.property.sy + group_pane.property.r * math.sin(group_pane.property.rad * math.pi / 2) + group_pane.property.rr / 2 * math.sin((group_pane.property.ro - 90) * math.pi / 180) * scale_y

        -- Set the pane's rotate
        group_pane.pane:set_rotate(0, 0, group_pane.property.ro)
        -- Set the pane's position
        group_pane.pane:set_position(pos_x, pos_y)
        -- Set the pane's scale
        group_pane.pane:set_scale(scale_x, scale_y)
    end
end

return value