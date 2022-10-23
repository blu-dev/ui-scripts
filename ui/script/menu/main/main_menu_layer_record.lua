local value = {}

button:add_id("COLLECTION_RECORD", "COUNT", 1)
button:add_id("COLLECTION_RECORD", "MEMORIAL", 2)
button:add_id("COLLECTION_RECORD", "FIGHTER", 3)
button:add_id("COLLECTION_RECORD", "CARD", 4)
button:add_id("COLLECTION_RECORD", "PLAYING", 5)

function value:initialize()
    self.layout_root = LayoutRootList.main_menu
    self.layout_view = self.layout_root:get_root_view()
    self.virtual_input = self.layout_root:get_virtual_input()

    self.in_anim = "appear_colle_record"
    self.out_anim = "disappear_colle_record"

    self.header = {}
    self.header.layout_view = self.layout_view:get_parts("set_header_colle_record")

    self.selector = LayoutButtonSelector.new()
    self.selector_parts = "set_menu_colle_record"
    self.selector_name = "selector"

    self.selector_config = LayoutButtonSelectorConfig.new()
    self.selector_config.bring_front_on_select = true
    self.selector_config.directional_degree = 60
    self.selector_config.use_cursor_looping = false
    self.selector_config.is_unique_se = true
    self.selector_config.decide_se_label_code = "se_system_fixed_s"
    self.selector_config.cancel_se_label_code = "se_system_cancel"
    self.selector_config.cursor_se_label_code = "se_system_cursor_l"
    self.selector_initial_id = button.COLLECTION_RECORD_COUNT

    self.button_table = {}
    self.button_table[button.COLLECTION_RECORD_COUNT] = {
        parts = "set_parts_btn_00",
        sequence = SEQUENCE_COLLECTION_RECORD_COUNT
    }
    self.button_table[button.COLLECTION_RECORD_MEMORIAL] = {
        parts = "set_parts_btn_01",
        sequence = SEQUENCE_COLLECTION_RECORD_MEMORIAL
    }
    self.button_table[button.COLLECTION_RECORD_FIGHTER] = {
        parts = "set_parts_btn_02",
        sequence = SEQUENCE_COLLECTION_RECORD_FIGHTER
    }
    self.button_table[button.COLLECTION_RECORD_CARD] = {
        parts = "set_parts_btn_03",
        sequence = SEQUENCE_COLLECTION_RECORD_CARD
    }
    self.button_table[button.COLLECTION_RECORD_PLAYING] = {
        parts = "set_parts_btn_04",
        sequence = SEQUENCE_COLLECTION_RECORD_PLAYING
    }

    self.footer_table = {}
    self.footer_table[button.COLLECTION_RECORD_COUNT] = {
        label = "mnu_coll_record_top_help_count"
    }
    self.footer_table[button.COLLECTION_RECORD_MEMORIAL] = {
        label = "mnu_coll_record_top_help_memorial"
    }
    self.footer_table[button.COLLECTION_RECORD_FIGHTER] = {
        label = "mnu_coll_record_top_help_fighter"
    }
    self.footer_table[button.COLLECTION_RECORD_CARD] = {
        label = "mnu_coll_record_top_help_opponents_card"
    }
    self.footer_table[button.COLLECTION_RECORD_PLAYING] = {
        label = "mnu_coll_record_top_help_history"
    }

    self.preview_table = {}
    self.preview_table.layout_view = self.layout_view:get_parts("set_preview_colle_record")
    self.preview_table[button.COLLECTION_RECORD_COUNT] = {
        tag = "select_count"
    }
    self.preview_table[button.COLLECTION_RECORD_MEMORIAL] = {
        tag = "select_memorial"
    }
    self.preview_table[button.COLLECTION_RECORD_FIGHTER] = {
        tag = "select_record_fighter"
    }
    self.preview_table[button.COLLECTION_RECORD_CARD] = {
        tag = "select_opponents_card"
    }
    self.preview_table[button.COLLECTION_RECORD_PLAYING] = {
        tag = "select_history"
    }
end

function value:setup_selector()
    local selector = self.layout_view:get_parts(self.selector_parts)
    local card_parts = selector:get_parts(self.button_table[button.COLLECTION_RECORD_CARD].parts)
    local badge = card_parts:get_parts("set_parts_badge")
    local num_pane = badge:get_pane("set_txt_count")
    num_pane:set_text_number_int32(prg_func.get_opponent_tag_count())
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