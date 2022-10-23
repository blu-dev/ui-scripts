local value = {}

button:add_id("COLLECTION", "SOUND", 1)
button:add_id("COLLECTION", "REPLAY", 2)
button:add_id("COLLECTION", "RECORD", 3)
button:add_id("COLLECTION", "CLEARGETTER", 4)
button:add_id("COLLECTION", "SMAKNOWLEDGE", 5)
button:add_id("COLLECTION", "MOVIE", 6)
button:add_id("COLLECTION", "SHOP", 7)
button:add_id("COLLECTION", "PRESENT", 8)

function value:initialize()
    self.layout_root = LayoutRootList.main_menu
    self.layout_view = self.layout_root:get_root_view()
    self.virtual_input = self.layout_root:get_virtual_input()
    self.in_anim = "appear_colle_top"
    self.out_anim = "disappear_colle_top"
    self.header = {}
    self.header.layout_view = self.layout_view:get_parts("set_header_colle")
    self.selector = LayoutButtonSelector.new()
    self.selector_parts = "set_menu_colle"
    self.selector_name = "selector_0"
    self.selector_config = LayoutButtonSelectorConfig.new()
    self.selector_config.bring_front_on_select = true
    self.selector_config.directional_degree = 60
    self.selector_config.use_cursor_looping = false
    self.selector_config.is_unique_se = true
    self.selector_config.decide_se_label_code = "se_system_fixed_s"
    self.selector_config.cancel_se_label_code = "se_system_cancel"
    self.selector_config.cursor_se_label_code = "se_system_cursor_l"
    self.selector_initial_id = button.COLLECTION_SOUND
    self.button_table = {}
    self.button_table[button.COLLECTION_SOUND] = {
        parts = "set_parts_btn_00",
        sequence = SEQUENCE_COLLECTION_SOUND
    }
    self.button_table[button.COLLECTION_REPLAY] = {
        parts = "set_parts_btn_01",
        state = STATE_REPLAY_IN
    }
    self.button_table[button.COLLECTION_RECORD] = {
        parts = "set_parts_btn_02",
        state = STATE_RECORD_IN
    }
    self.button_table[button.COLLECTION_CLEARGETTER] = {
        parts = "set_parts_btn_03",
        sequence = SEQUENCE_COLLECTION_CLEARGETTER
    }
    self.button_table[button.COLLECTION_SMAKNOWLEDGE] = {
        parts = "set_parts_btn_04",
        sequence = SEQUENCE_COLLECTION_SMAKNOWLEDGE
    }
    self.button_table[button.COLLECTION_MOVIE] = {
        parts = "set_parts_btn_05",
        sequence = SEQUENCE_COLLECTION_MOVIE
    }
    self.button_table[button.COLLECTION_SHOP] = {
        parts = "set_parts_btn_06",
        sequence = SEQUENCE_COLLECTION_SHOP
    }
    self.button_table[button.COLLECTION_PRESENT] = {
        parts = "set_parts_btn_07",
        sequence = SEQUENCE_COLLECTION_PRESENT
    }
    self.footer_table = {}
    self.footer_table[button.COLLECTION_SOUND] = {
        label = "mnu_coll_top_help_soundtest"
    }
    self.footer_table[button.COLLECTION_REPLAY] = {
        label = "mnu_coll_top_help_album"
    }
    self.footer_table[button.COLLECTION_RECORD] = {
        label = "mnu_coll_top_help_record"
    }
    self.footer_table[button.COLLECTION_CLEARGETTER] = {
        label = "mnu_coll_top_help_cleargeter"
    }
    self.footer_table[button.COLLECTION_SMAKNOWLEDGE] = {
        label = "mnu_coll_top_help_tips"
    }
    self.footer_table[button.COLLECTION_MOVIE] = {
        label = "mnu_coll_top_help_movie"
    }
    self.footer_table[button.COLLECTION_SHOP] = {
        label = "mnu_coll_top_help_shop"
    }
    self.footer_table[button.COLLECTION_PRESENT] = {
        label = "mnu_coll_top_help_present"
    }
    self.preview_table = {}
    self.preview_table.layout_view = self.layout_view:get_parts("set_preview_colle")
    self.preview_table[button.COLLECTION_SOUND] = {
        tag = "select_soundtest"
    }
    self.preview_table[button.COLLECTION_REPLAY] = {
        tag = "select_replay"
    }
    self.preview_table[button.COLLECTION_RECORD] = {
        tag = "select_record"
    }
    self.preview_table[button.COLLECTION_CLEARGETTER] = {
        tag = "select_cleargeter"
    }
    self.preview_table[button.COLLECTION_SMAKNOWLEDGE] = {
        tag = "select_tips"
    }
    self.preview_table[button.COLLECTION_MOVIE] = {
        tag = "select_movie"
    }
    self.preview_table[button.COLLECTION_SHOP] = {
        tag = "select_shop"
    }
    self.preview_table[button.COLLECTION_PRESENT] = {
        tag = "select_present"
    }
end

function value:setup_selector()
    local present_button = self.selector:get_button(button.COLLECTION_PRESENT)
    local is_valid = prg_func.is_valid_present()
    present_button:set_decidable(is_valid)
    local selector_parts = self.layout_view:get_parts(self.selector_parts)
    local present_parts = selector_parts:get_parts(self.button_table[button.COLLECTION_PRESENT].parts)
    local is_valid_ = is_valid and prg_func.is_valid_new_present()
    common.play_animation(present_parts, is_valid_ and "show_icon_exc" or "hide_icon_exc", true)
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