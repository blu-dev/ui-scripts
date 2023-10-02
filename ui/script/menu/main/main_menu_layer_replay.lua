--[[
FILE: main_menu_layer_replay.lua
Reference Code: main_menu_layer_replay.lc

Author: jozz, blujay (a lot of the code was referenced from other main menu files which he rewrote)

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light
Also used the other main menu files as a reference.

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of main_menu_layer_replay.lc
when unmodified.
]]--

local value = {}

button:add_id("COLLECTION_REPLAY", "DATA", 1)
button:add_id("COLLECTION_REPLAY", "VIDEO", 2)
button:add_id("COLLECTION_REPLAY", "EDIT", 3)

function value:initialize ()
    self.layout_root = LayoutRootList.colle_popup
    self.layout_view = self.layout_root:get_root_view()
    self.layout_view:stop_animation_at_end("out")
    self.virtual_input = self.layout_root:get_virtual_input()
    self.in_anim = "in"
    self.out_anim = "out"
    self.selector = LayoutButtonSelector.new()
    self.selector_name = "selector_0"
    self.selector_config = LayoutButtonSelectorConfig.new()
    self.selector_config.directional_degree = 60
    self.selector_config.use_cursor_looping = false
    self.selector_config.is_unique_se = true
    self.selector_config.decide_se_label_code = "se_system_fixed_s"
    self.selector_config.cancel_se_label_code = "se_system_cancel"
    self.selector_config.cursor_se_label_code = "se_system_cursor_l"
    self.selector_initial_id = button.COLLECTION_REPLAY_DATA
    self.button_table = {}
    self.button_table[button.COLLECTION_REPLAY_DATA] =
    {
        parts = "set_parts_btn_00",
        sequence = SEQUENCE_COLLECTION_REPLAY_DATA
    }
    self.button_table[button.COLLECTION_REPLAY_VIDEO] =
    {
        parts = "set_parts_btn_01",
        sequence = SEQUENCE_COLLECTION_REPLAY_VIDEO
    }
    self.button_table[button.COLLECTION_REPLAY_EDIT] =
    {
        parts = "set_parts_btn_02",
        sequence = SEQUENCE_COLLECTION_REPLAY_EDIT
    }
    self.footer_table = {}
    self.footer_table[button.COLLECTION_REPLAY_DATA] =
    {
        label = "mnu_replay_help_replay_data"
    }
    self.footer_table[button.COLLECTION_REPLAY_VIDEO] =
    {
        label = "mnu_replay_help_movie"
    }
    self.footer_table[button.COLLECTION_REPLAY_EDIT] =
    {
        label = "mnu_replay_help_movie_edit"
    }
    self.preview_table = {}
    self.preview_table.layout_view = self.layout_view
    self.preview_table[button.COLLECTION_REPLAY_DATA] =
    {
        tag = "preview_00"
    }
    self.preview_table[button.COLLECTION_REPLAY_VIDEO] =
    {
        tag = "preview_01"
    }
    self.preview_table[button.COLLECTION_REPLAY_EDIT] =
    {
        tag = "preview_02"
    }
    self.howto_table = {}
    self.howto_table[button.COLLECTION_REPLAY_DATA] =
    {
        id = "UI_HOWTOPLAY_REPLAY_TOP"
    }
    self.howto_table[button.COLLECTION_REPLAY_EDIT] =
    {
        id = "UI_HOWTOPLAY_EDIT_MOVIE_TOP"
    }
    self.enable_screen_blur = true
end

function value:setup_selector ()
    common.play_animation(self.layout_view, "lay_01")
end

function value:update_state_in()
    common.update_state_in(self)
end

function value:update_state_main()
    common.update_state_main(self)
end

function value:update_state_out()
    common.update_state_out(self)
end

return value