local value = {}

button:add_id("MELEE_SPECIAL", "VARIOUS", 1)
button:add_id("MELEE_SPECIAL", "ALLBATTLE", 2)
button:add_id("MELEE_SPECIAL", "SUDDENDEATH", 3)

function value:initialize()
    self.layout_root = LayoutRootList.main_menu
    self.layout_view = self.layout_root:get_root_view()
    self.virtual_input = self.layout_root:get_virtual_input()

    self.in_anim = "appear_melee_special"
    self.out_anim = "disappear_melee_special"

    self.header = {}
    self.header.layout_view = self.layout_view:get_parts("set_header_special")

    self.selector = LayoutButtonSelector.new()
    self.selector_parts = "set_menu_melee_special"
    self.selector_name = "selector"

    self.selector_config = LayoutButtonSelectorConfig.new()
    self.selector_config.bring_front_on_select = true
    self.selector_config.directional_degree = 60
    self.selector_config.use_cursor_looping = false
    self.selector_config.is_unique_se = true
    self.selector_config.decide_se_label_code = "se_system_fixed_s"
    self.selector_config.cancel_se_label_code = "se_system_cancel"
    self.selector_config.cursor_se_label_code = "se_system_cursor_l"
    self.selector_initial_id = button.MELEE_SPECIAL_VARIOUS

    self.button_table = {}
    self.button_table[button.MELEE_SPECIAL_VARIOUS] = {
        parts = "set_parts_btn_00",
        sequence = SEQUENCE_MELEE_SPECIAL_VARIOUS
    }
    self.button_table[button.MELEE_SPECIAL_ALLBATTLE] = {
        parts = "set_parts_btn_01",
        sequence = SEQUENCE_MELEE_SPECIAL_ALL_BATTLE
    }
    self.button_table[button.MELEE_SPECIAL_SUDDENDEATH] = {
        parts = "set_parts_btn_02",
        sequence = SEQUENCE_MELEE_SPECIAL_SUDDENDEATH
    }

    self.footer_table = {}
    self.footer_table[button.MELEE_SPECIAL_VARIOUS] = {
        label = "mnu_mel_sp_top_help_various"
    }
    self.footer_table[button.MELEE_SPECIAL_ALLBATTLE] = {
        label = "mnu_mel_sp_top_help_allbattle"
    }
    self.footer_table[button.MELEE_SPECIAL_SUDDENDEATH] = {
        label = "mnu_mel_sp_top_help_suddendeath"
    }

    self.preview_table = {}
    self.preview_table.layout_view = self.layout_view:get_parts("set_preview_special")
    self.preview_table[button.MELEE_SPECIAL_VARIOUS] = {
        tag = "select_various"
    }
    self.preview_table[button.MELEE_SPECIAL_ALLBATTLE] = {
        tag = "select_allbattle"
    }
    self.preview_table[button.MELEE_SPECIAL_SUDDENDEATH] = {
        tag = "select_suddendeath"
    }

    self.howto_table = {}
    self.howto_table[button.MELEE_SPECIAL_ALLBATTLE] = {
        id = "UI_HOWTOPLAY_ALL_BATTLE_TOP"
    }
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