local value = {}

button:add_id("OTHER_HOMERUN", "SINGLE", 1)
button:add_id("OTHER_HOMERUN", "COOP", 2)
button:add_id("OTHER_HOMERUN", "EVERYONE", 3)

function value:initialize()
    self.layout_root = LayoutRootList.other_popup_homerun
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
    self.selector_initial_id = button.OTHER_HOMERUN_SINGLE
    self.button_table = {}
    self.button_table[button.OTHER_HOMERUN_SINGLE] = {
        parts = "set_parts_btn_00",
        sequence = SEQUENCE_OTHER_HOMERUN_SINGLE
    }
    self.button_table[button.OTHER_HOMERUN_COOP] = {
        parts = "set_parts_btn_01",
        sequence = SEQUENCE_OTHER_HOMERUN_COOP
    }
    self.button_table[button.OTHER_HOMERUN_EVERYONE] = {
        parts = "set_parts_btn_02",
        sequence = SEQUENCE_OTHER_HOMERUN_EVERYONE
    }
    self.footer_table = {}
    self.footer_table[button.OTHER_HOMERUN_SINGLE] = {
        label = "mnu_oth_pop_help_homerun_single"
    }
    self.footer_table[button.OTHER_HOMERUN_COOP] = {
        label = "mnu_oth_pop_help_homerun_coop"
    }
    self.footer_table[button.OTHER_HOMERUN_EVERYONE] = {
        label = "mnu_oth_pop_help_homerun_everyone"
    }
    self.preview_table = {}
    self.preview_table.layout_view = self.layout_view
    self.preview_table[button.OTHER_HOMERUN_SINGLE] = {
        tag = "preview_00"
    }
    self.preview_table[button.OTHER_HOMERUN_COOP] = {
        tag = "preview_01"
    }
    self.preview_table[button.OTHER_HOMERUN_EVERYONE] = {
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