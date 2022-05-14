--[[
FILE: main_menu_footer.lua
Reference Code: main_menu_footer.lc

Author: blujay

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of main_menu_footer.lc
when unmodified.
]]--
local footer = {}

function footer:initialize ()
    self.layout_root = LayoutRootList.main_menu_footer
    self.layout_view = self.layout_root:get_root_view()
    self.in_pane = self.layout_view:get_pane("set_txt_00")
    self.out_pane = self.layout_view:get_pane("set_txt_01")
end

function footer:finalize ()

end

function footer:appear ()
    common.play_animation(self.layout_view, "footer_help_in")
end

function footer:disappear ()
    common.play_animation(self.layout_view, "footer_help_out")
end

function footer:change ()
    local func = state:is_first() and common.skip_animation or common.play_animation
    func(self.layout_view, "anim_select")
end

function footer:set_label (pane, message)
    if message then
        pane:set_text_message(message)
    else
        pane:clear_text_string()
    end
end

function footer:update (selector)
    if selector.footer_table then
        local entry = selector.footer_table[selector.selector_id]
        if entry and entry.label and (not self.prev_label or entry.label ~= self.prev_label) then
            self:set_label(self.in_pane, entry.label)
            self:set_label(self.out_pane, self.prev_label)
            self.prev_label = entry.label
            self:change()
        end
    end
end

return footer