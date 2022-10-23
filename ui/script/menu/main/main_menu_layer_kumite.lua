local value = {}

button:add_id("OTHER_KUMITE", "HUNDRED", 1)
button:add_id("OTHER_KUMITE", "ALLSTAR", 2)
button:add_id("OTHER_KUMITE", "CRUEL", 3)

function value:initialize()
    self.layout_root = LayoutRootList.other_popup
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
    self.selector_initial_id = button.OTHER_KUMITE_HUNDRED
    self.button_table = {}
    self.button_table[button.OTHER_KUMITE_HUNDRED] = {
        parts = "set_parts_btn_00",
        sequence = SEQUENCE_OTHER_KUMITE_100
    }
    self.button_table[button.OTHER_KUMITE_ALLSTAR] = {
        parts = "set_parts_btn_01",
        sequence = SEQUENCE_OTHER_KUMITE_ALLSTAR
    }
    self.button_table[button.OTHER_KUMITE_CRUEL] = {
        parts = "set_parts_btn_02",
        sequence = SEQUENCE_OTHER_KUMITE_CRUEL
    }
    self.footer_table = {}
    self.footer_table[button.OTHER_KUMITE_HUNDRED] = {
        label = "mnu_oth_pop_help_spar_hundred"
    }
    self.footer_table[button.OTHER_KUMITE_ALLSTAR] = {
        label = "mnu_oth_pop_help_spar_allstar"
    }
    self.footer_table[button.OTHER_KUMITE_CRUEL] = {
        label = "mnu_oth_pop_help_spar_ruthless"
    }
    self.preview_table = {}
    self.preview_table.layout_view = self.layout_view
    self.preview_table[button.OTHER_KUMITE_HUNDRED] = {
        tag = "preview_00"
    }
    self.preview_table[button.OTHER_KUMITE_ALLSTAR] = {
        tag = "preview_01"
    }
    self.preview_table[button.OTHER_KUMITE_CRUEL] = {
        tag = "preview_02"
    }
    self.enable_screen_blur = true 
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