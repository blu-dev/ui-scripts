--[[
FILE: main_menu_bg_anim.lua
Reference Code: main_menu_bg_anim.lc

Author: blujay

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of main_menu_bg_anim.lc
when unmodified.
]]--
local bg_anim = {}

function bg_anim:initialize (layout_view)
    self.panes_particle_00 = get_panes(layout_view, "ptl_emitter_00", "anim")
    self.init_anim_particle(self.panes_particle_00)

    self.panes_particle_01 = get_panes(layout_view, "ptl_emitter_01", "anim")
    self.init_anim_particle(self.panes_particle_01)

    self.panes_particle_02 = get_panes(layout_view, "ptl_emitter_02", "anim")
    self.init_anim_particle(self.panes_particle_02)
end

function bg_anim:finalize ()
    self.panes_particle_00 = nil
    self.panes_particle_01 = nil
    self.panes_particle_02 = nil
end

function bg_anim:update ()
    self.loop_anim_particle(self.panes_particle_00, "fire")
    self.loop_anim_particle(self.panes_particle_01, "fire")
    self.loop_anim_particle(self.panes_particle_02, "fire")
end

bg_anim.init_anim_particle = function (particle_set)
    for index, particle in ipairs(particle_set) do
        local x = module_ui_common.get_random() * 3000 - 1500
        local y = module_ui_common.get_random() * 3000 - 1500
        particle.pane:set_position(x, y)

        -- nope, smash devs forgot the `local` keyword and also spelled alpha wrong
        -- this isn't me
        aplha = module_ui_common.get_random() * 100
        particle.pane:set_alpha(aplha)
        scale = module_ui_common.get_random() * 0.85
        particle.pane:set_scale(scale, scale)
    end

    for index, particle in ipairs(particle_set) do
        local direction = 1
        if module_ui_common.get_random() < 0.5 then
            direction = -1
        end
        
        particle.property = {
            x_sp = 5 * module_ui_common.get_random() + 3,
            y_sp = 3 * module_ui_common.get_random() + 2,
            r = module_ui_common.get_random() * 4 + 0.2,
            r_speed = module_ui_common.get_random() * 100 + 20,
            down_scale = module_ui_common.get_random() * 0.006,
            r_dir = direction
        }
    end
end

bg_anim.loop_anim_particle = function (particle_set, name)
    for index, particle in ipairs(particle_set) do
        local x, y = particle.pane:get_position()
        local sx, sy = particle.pane:get_scale()

        if 2500 < x then
            x = module_ui_common.get_random() * 2000 - 1000
            y = 0
            local new_scale = module_ui_common.get_random()
            particle.pane:set_scale(new_scale, new_scale)
        else
            x = x + particle.property.x_sp
            y = y + particle.property.y_sp
            local scale_x, scale_y = particle.pane:get_scale()
            scale_x = scale_x - particle.property.down_scale
            if scale_x < 0 then
                scale_x = 0
            end
            particle.pane:set_scale(scale_x, scale_x)
        end
        local r = particle.property.r
        local speed = particle.property.r_speed
        local dir = particle.property.r_dir
        x = r * math.sin(y / speed * dir) + x
        particle.pane:set_position(x, y)
    end
end

return bg_anim