local value = {}

button:add_id("SPIRITS", "CANPAIGN", 1)
button:add_id("SPIRITS", "CHALLENGE", 2)
button:add_id("SPIRITS", "FORMATION", 3)
button:add_id("SPIRITS", "BANNER", 4)
button:add_id("SPIRITS", "DLC", 5)

function value:initialize()
    self.layout_root = LayoutRootList.main_menu
    self.layout_view = self.layout_root:get_root_view()
    self.virtual_input = self.layout_root:get_virtual_input()

    self.in_anim = "appear_spirits_top"
    self.out_anim = "disappear_spirits_top"

    self.header = {}
    self.header.layout_view = self.layout_view:get_parts("set_header_spirits")

    self.selector = LayoutButtonSelector.new()
    self.selector_parts = "set_menu_spirits"
    self.selector_name = "selector_0"

    self.selector_config = LayoutButtonSelectorConfig.new()
    self.selector_config.bring_front_on_select = true
    self.selector_config.directional_degree = 60
    self.selector_config.use_cursor_looping = false
    self.selector_config.is_unique_se = true
    self.selector_config.decide_se_label_code = "se_system_fixed_s"
    self.selector_config.cancel_se_label_code = "se_system_cancel"
    self.selector_config.cursor_se_label_code = "se_system_cursor_l"
    self.selector_initial_id = button.SPIRITS_CANPAIGN

    self.button_table = {}
    self.button_table[button.SPIRITS_CANPAIGN] = {
        parts = "set_parts_btn_00",
        sequence = SEQUENCE_SPIRITS_CANPAIGN
    }
    self.button_table[button.SPIRITS_CHALLENGE] = {
        parts = "set_parts_btn_01",
        sequence = SEQUENCE_SPIRITS_CHALLENGE
    }
    self.button_table[button.SPIRITS_FORMATION] = {
        parts = "set_parts_btn_02",
        sequence = SEQUENCE_SPIRITS_FORMATION
    }
    self.button_table[button.SPIRITS_BANNER] = {
        parts = "set_parts_btn_03",
        func_decide = self.callback_banner_decide,
        func_lr = self.callback_banner_lr
    }
    self.button_table[button.SPIRITS_DLC] = {
        parts = "set_parts_btn_04",
        state = STATE_DLC_IN
    }

    self.footer_table = {}
    self.footer_table[button.SPIRITS_CANPAIGN] = {
        label = "mnu_spi_top_help_campaign"
    }
    self.footer_table[button.SPIRITS_CHALLENGE] = {
        label = "mnu_spi_top_help_spirits_board"
    }
    self.footer_table[button.SPIRITS_FORMATION] = {
        label = "mnu_spi_top_help_organization"
    }
    self.footer_table[button.SPIRITS_BANNER] = {
        label = "mnu_spi_top_help_banner"
    }
    self.footer_table[button.SPIRITS_DLC] = {
        label = "mnu_spi_top_help_dlc"
    }

    self.preview_table = {}
    self.preview_table.layout_view = self.layout_view:get_parts("set_menu_preview_spirits")

    self.preview_table[button.SPIRITS_CANPAIGN] = {
        tag = "select_adventure"
    }
    self.preview_table[button.SPIRITS_CHALLENGE] = {
        tag = "select_board"
    }
    self.preview_table[button.SPIRITS_FORMATION] = {
        tag = "select_organize"
    }
    self.preview_table[button.SPIRITS_BANNER] = {
        tag = "select_event"
    }
    self.preview_table[button.SPIRITS_DLC] = {
        tag = "select_dlc"
    }

    self.howto_table = {}
    self.howto_table[button.SPIRITS_CHALLENGE] = {
        id = "UI_HOWTOPLAY_SPIRITS_BOARD_TOP"
    }
    self.howto_table[button.SPIRITS_DLC] = {
        id = "UI_HOWTOPLAY_DLC_BOARD_TOP"
    }

    self.banner_table = actor:get_spirits_banner_data()
    local selector = self.layout_view:get_parts(self.selector_parts)
    if 0 < #self.banner_table then
        local banner_parts = selector:get_parts(self.button_table[button.SPIRITS_BANNER].parts)
        self.banner = UiScriptPlayer.require("menu/main/main_menu_banner")
        self.banner:initialize(banner_parts, self.banner_table)
        common.play_animation(selector, "show_banner")
    else
        common.play_animation(selector, "hide_banner")
    end
end

function value:setup_selector()
    local selector = self.layout_view:get_parts(self.selector_parts)

    local dlc_parts = selector:get_parts(self.button_table[button.SPIRITS_DLC].parts)
    local is_new_fighter = false
    for i, fighter_name in ipairs(dlc_fighter_list) do
        if prg_func.is_new_dlc_fighter(fighter_name) then
            is_new_fighter = true
            break
        end
    end
    common.play_animation(dlc_parts, is_new_fighter and "show_icon_exc" or "hide_icon_exc", true)
    local is_rematch = false
    if prg_func.is_new_directory_rematch(v) then
        is_rematch = true
    end
    local board_parts = selector:get_parts(self.button_table[button.SPIRITS_FORMATION].parts)
    common.play_animation(board_parts, is_rematch and "show_icon_exc" or "hide_icon_exc", true)
end

function value:callback_banner_decide()
    if self.banner then
        common.wait(1)
        self.banner:decide()
    end
end

function value:callback_banner_lr(lr)
    if self.banner then
        self.banner:move_lr(lr, true)
    end
end

function value:update_state_in()
    common.update_state_in(self)
end

function value:update_state_main()
    if state:is_first() then
        self:setup_selector()
    end
    common.update_state_main(self)
end

function value:update_state_out()
    common.update_state_out(self)
end

return value