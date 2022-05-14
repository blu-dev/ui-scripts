--[[
FILE: main_menu_banner.lua
Reference Code: main_menu_banner.lc

Author: blujay

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of main_menu_banner.lc
when unmodified.
]]--
local banner = {}

function banner:initialize (layout_view, param)
    self.layout_view = layout_view
    self.param = param
    self.in_parts = self.layout_view:get_parts("set_parts_banner_in")
    self.out_parts = self.layout_view:get_parts("set_parts_banner_out")
    common.play_animation(self.layout_view, "view_banner_" .. #self.param - 1)
    self.locale_jp = prg_func.is_locale_japan()

    local locale = self.locale_jp and "view_jp" or "view_other"

    common.play_animation(self.in_parts, locale)
    common.play_animation(self.out_parts, locale)
    self:reset()
end

function banner:finalize ()
end

function banner:reset ()
    self.count = 0
    self.index = 1
    self:change(self.index, 0)
end

function banner:update ()
    self.count = self.count + 1
    if 300 <= self.count then
        self:move_lr(false)
    end
end

function banner:decide ()
    self.count = 0
    prg_func.show_event_page(self.param[self.index].url)
    while prg_func.is_showing_event_page() do
        coroutine.yield()
    end
end

function banner:move_lr (move_left, play_anim)
    if #self.param > 1 then
        local real_index = self.index - 1
        local add_term = (move_left and (#self.param - 1) or 1)
        real_index = (real_index + add_term) % #self.param
        self:change(real_index + 1, move_left and -1 or 1)
        if play_anim then
            local anim_name = "anim_on_txt_" .. (move_left and "l" or "r")
            common.play_animation(self.layout_view, anim_name)
        end
    end
end

function banner:change (new_index, direction)
    self:set(self.in_parts, new_index)
    self:set(self.out_parts, self.index)
    self.index = new_index
    self.count = 0
    if 0 < direction then
        common.play_animation(self.layout_view, "anim_left")
    elseif direction < 0 then
        common.play_animation(self.layout_view, "anim_right")
    end

    for i=1, #self.param, 1 do
        local parts = self.layout_view:get_parts("set_parts_dot_" .. i - 1)
        local anim = (i == new_index) and "on" or "off"
        common.play_animation(parts, anim)
    end
end

function banner:set (parts, index)
    local param = self.param[index]
    local image_pane = parts:get_pane("set_rep_image")
    if param.type == BANNER_CONVENTION then
        common.play_animation(parts, "bg_compe")
        image_pane:restore_texture()
    else
        common.play_animation(parts, "bg_event")
        image_pane:replace_image_texture(param.texture)
    end

    local locale_suffix = self.locale_jp and "" or "_other"

    local text_pane = parts:get_pane("set_txt_title" .. locale_suffix)
    local text_shadow = parts:get_pane("set_txt_title_sdw" .. locale_suffix)
    local title_size = parts:get_pane("set_title_size")
    self:set_text_desc(text_pane, text_shadow, title_size, param.title_desc)

    if param.type == BANNER_SPIRITS then
        local label = "mnu_spi_top_banner_title"
        text_pane:set_text_message_args(label, param.title, "s")
        text_shadow:set_text_message_args(label, param.title, "s")
    elseif param.type == BANNER_TOURNAMENT then
        local label = "mnu_onl_top_event_tournament_title"
        text_pane:set_text_message_args(label, param.title, "s")
        text_shadow:set_text_message_args(label, param.title, "s")
    elseif param.type == BANNER_CONVENTION then
        local label = "mnu_onl_top_event_convention_title"
        text_pane:set_text_message_args(label, param.title, "p")
        text_shadow:set_text_message_args(label, param.title, "p")
    else
        text_pane:clear_text_string()
        text_shadow:clear_text_string()
    end

    local date_pane = parts:get_pane("set_txt_period")
    local date_shadow = parts:get_pane("set_txt_period_sdw")
    local date_size = parts:get_pane("set_period_size")
    self:set_text_desc(date_pane, date_shadow, date_size, param.period_desc)
    if param.type == BANNER_SPIRITS then
        local label = "mnu_spi_top_banner_date"
        date_pane:set_text_message_args(label, param.begin_date, param.begin_time, param.end_date, param.end_time, "iiii")
        date_shadow:set_text_message_args(label, param.begin_date, param.begin_time, param.end_date, param.end_time, "iiii")
    elseif param.type == BANNER_TOURNAMENT then
        local label = "mnu_onl_top_event_tournament_date"
        date_pane:set_text_message_args(label, param.begin_date, param.begin_time, param.end_date, param.end_time, "iiii")
        date_shadow:set_text_message_args(label, param.begin_date, param.begin_time, param.end_date, param.end_time, "iiii")
    elseif param.type == BANNER_CONVENTION then
        local label = "mnu_onl_top_event_convention_date"
        date_pane:set_text_message_args(label, param.begin_date, param.begin_time, param.end_time, "iii")
        date_shadow:set_text_message_args(label, param.begin_date, param.begin_time, param.end_time, "iii")
    else
        date_pane:clear_text_string()
        date_shadow:clear_text_string()
    end
end

function banner:set_text_desc (text_pane, shadow_pane, size_pane, text)
    local w, h = size_pane:get_size()
    local alignment_options = {
        0,
        -1,
        1
    }

    local x_position = text.pos_x + alignment_options[text.align_x + 1] * (1 - text.scale_x) * w / 2
    w = w * text.scale_x

    text_pane:set_position(x_position, text.pos_y)
    text_pane:set_size(w, h)
    text_pane:set_text_alignment_x(text.align_x)
    text_pane:set_text_alignment_y(text.align_y)
    text_pane:set_text_color(text.text_color)
    text_pane:set_text_border_enable(text.border)
    text_pane:set_text_border_color(text.border_color)
    text_pane:set_text_shadow_color(0)

    shadow_pane:set_position(x_position, text.pos_y)
    shadow_pane:set_size(w, h)
    shadow_pane:set_text_alignment_x(text.align_x)
    shadow_pane:set_text_alignment_y(text.align_y)
    shadow_pane:set_text_color(0)
    shadow_pane:set_text_border_enable(false)
    shadow_pane:set_text_border_color(0)
    if text.shadow then
        shadow_pane:set_text_shadow_color(text.shadow_color)
    else
        shadow_pane:set_text_shadow_color(0)
    end
end

return banner