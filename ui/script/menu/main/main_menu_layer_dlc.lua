local value = {}

button:add_id("SPIRITS_DLC", "FIGHTER00", 1)
button:add_id("SPIRITS_DLC", "FIGHTER01", 2)
button:add_id("SPIRITS_DLC", "FIGHTER02", 3)
button:add_id("SPIRITS_DLC", "FIGHTER03", 4)
button:add_id("SPIRITS_DLC", "FIGHTER04", 5)
button:add_id("SPIRITS_DLC", "FIGHTER05", 6)
button:add_id("SPIRITS_DLC", "FIGHTER06", 7)
button:add_id("SPIRITS_DLC", "FIGHTER07", 8)
button:add_id("SPIRITS_DLC", "FIGHTER08", 9)
button:add_id("SPIRITS_DLC", "FIGHTER09", 10)
button:add_id("SPIRITS_DLC", "FIGHTER10", 11)

function value:initialize()
    self.layout_root = LayoutRootList.spirits_board_special_popup
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
    self.selector_initial_id = button.SPIRITS_DLC_FIGHTER00
    self.button_table = {}
    self.button_table[button.SPIRITS_DLC_FIGHTER00] = {
        parts = "set_parts_btn_00",
        func_decide = self.callback_decide
    }
    self.button_table[button.SPIRITS_DLC_FIGHTER01] = {
        parts = "set_parts_btn_01",
        func_decide = self.callback_decide
    }
    self.button_table[button.SPIRITS_DLC_FIGHTER02] = {
        parts = "set_parts_btn_02",
        func_decide = self.callback_decide
    }
    self.button_table[button.SPIRITS_DLC_FIGHTER03] = {
        parts = "set_parts_btn_03",
        func_decide = self.callback_decide
    }
    self.button_table[button.SPIRITS_DLC_FIGHTER04] = {
        parts = "set_parts_btn_04",
        func_decide = self.callback_decide
    }
    self.button_table[button.SPIRITS_DLC_FIGHTER05] = {
        parts = "set_parts_btn_05",
        func_decide = self.callback_decide
    }
    self.button_table[button.SPIRITS_DLC_FIGHTER06] = {
        parts = "set_parts_btn_06",
        func_decide = self.callback_decide
    }
    self.button_table[button.SPIRITS_DLC_FIGHTER07] = {
        parts = "set_parts_btn_07",
        func_decide = self.callback_decide
    }
    self.button_table[button.SPIRITS_DLC_FIGHTER08] = {
        parts = "set_parts_btn_08",
        func_decide = self.callback_decide
    }
    self.button_table[button.SPIRITS_DLC_FIGHTER09] = {
        parts = "set_parts_btn_09",
        func_decide = self.callback_decide
    }
    self.button_table[button.SPIRITS_DLC_FIGHTER10] = {
        parts = "set_parts_btn_10",
        func_decide = self.callback_decide
    }
    self.footer_table = {}
    self.footer_table[button.SPIRITS_DLC_FIGHTER00] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.footer_table[button.SPIRITS_DLC_FIGHTER01] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.footer_table[button.SPIRITS_DLC_FIGHTER02] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.footer_table[button.SPIRITS_DLC_FIGHTER03] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.footer_table[button.SPIRITS_DLC_FIGHTER04] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.footer_table[button.SPIRITS_DLC_FIGHTER05] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.footer_table[button.SPIRITS_DLC_FIGHTER06] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.footer_table[button.SPIRITS_DLC_FIGHTER07] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.footer_table[button.SPIRITS_DLC_FIGHTER08] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.footer_table[button.SPIRITS_DLC_FIGHTER09] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.footer_table[button.SPIRITS_DLC_FIGHTER10] = {
        label = "mnu_spirits_dlc_pop_help"
    }
    self.preview_table = {}
    self.preview_table.layout_view = self.layout_view
    self.preview_table[button.SPIRITS_DLC_FIGHTER00] = {
        tag = "preview_00"
    }
    self.preview_table[button.SPIRITS_DLC_FIGHTER01] = {
        tag = "preview_01"
    }
    self.preview_table[button.SPIRITS_DLC_FIGHTER02] = {
        tag = "preview_02"
    }
    self.preview_table[button.SPIRITS_DLC_FIGHTER03] = {
        tag = "preview_03"
    }
    self.preview_table[button.SPIRITS_DLC_FIGHTER04] = {
        tag = "preview_04"
    }
    self.preview_table[button.SPIRITS_DLC_FIGHTER05] = {
        tag = "preview_05"
    }
    self.preview_table[button.SPIRITS_DLC_FIGHTER06] = {
        tag = "preview_06"
    }
    self.preview_table[button.SPIRITS_DLC_FIGHTER07] = {
        tag = "preview_07"
    }
    self.preview_table[button.SPIRITS_DLC_FIGHTER08] = {
        tag = "preview_08"
    }
    self.preview_table[button.SPIRITS_DLC_FIGHTER09] = {
        tag = "preview_09"
    }
    self.preview_table[button.SPIRITS_DLC_FIGHTER10] = {
        tag = "preview_10"
    }
    self.dlc_table = {}
    self.dlc_table[button.SPIRITS_DLC_FIGHTER00] = {
        name = dlc_fighter_list[1]
    }
    self.dlc_table[button.SPIRITS_DLC_FIGHTER01] = {
        name = dlc_fighter_list[2]
    }
    self.dlc_table[button.SPIRITS_DLC_FIGHTER02] = {
        name = dlc_fighter_list[3]
    }
    self.dlc_table[button.SPIRITS_DLC_FIGHTER03] = {
        name = dlc_fighter_list[4]
    }
    self.dlc_table[button.SPIRITS_DLC_FIGHTER04] = {
        name = dlc_fighter_list[5]
    }
    self.dlc_table[button.SPIRITS_DLC_FIGHTER05] = {
        name = dlc_fighter_list[6]
    }
    self.dlc_table[button.SPIRITS_DLC_FIGHTER06] = {
        name = dlc_fighter_list[7]
    }
    self.dlc_table[button.SPIRITS_DLC_FIGHTER07] = {
        name = dlc_fighter_list[8]
    }
    self.dlc_table[button.SPIRITS_DLC_FIGHTER08] = {
        name = dlc_fighter_list[9]
    }
    self.dlc_table[button.SPIRITS_DLC_FIGHTER09] = {
        name = dlc_fighter_list[10]
    }
    self.dlc_table[button.SPIRITS_DLC_FIGHTER10] = {
        name = dlc_fighter_list[11]
    }
    self.enable_screen_blur = true
end

function value:setup_selector()
    for key, value in pairs(self.dlc_table) do
        local parts = self.layout_view:get_parts(self.button_table[key].parts)
        local button = self.selector:get_button(key)
        if value.name then
            button:set_disabled(false)
            local is_new = prg_func.is_new_dlc_fighter(value.name)
            common.play_animation(parts, is_new and "show_badge" or "hide_badge")
            if prg_func.is_unlock_dlc_fighter(value.name) then
                self.button_table[key].func_arg = {
                    name = value.name,
                    unlock = true,
                }
                self.button_table[key].sequence = SEQUENCE_SPIRITS_CHALLENGE_SPECIAL
            else
                self.button_table[key].func_arg = {
                    name = value.name,
                    unlock = false
                }
                self.button_table[key].sequence = nil
            end
        else
            button:set_disabled(true)
            common.play_animation(parts, "hide_badge")
        end
    end
end

function value:callback_decide(fighter)
    prg_func.clear_new_dlc_fighter(fighter.name)
    self:setup_selector()
    if fighter.unlock then
        prg_func.set_selected_dlc_fighter(fighter.name)
    else
        AppPopupManager.open_database("ID_POPUP_SPI_TOP_DLC_NOTICE")
        while AppPopupManager.is_busy() do
            coroutine.yield()
        end
        if AppPopupManager.get_result() == POPUP_RESULT_BUTTON2 then
            if not prg_func.is_valid_dlc_fighter_eshop_id() then
                self.layout_root:set_enable_input(false)
                FadeManager.fade_out()
                prg_func.refresh_dlc_fighter_eshop_id()
                repeat
                    coroutine.yield()
                until prg_func.is_refresh_complete_dlc_fighter_eshop_id()
                self.layout_root:set_enable_input(true)
            end
            local eshop_id = prg_func.get_dlc_fighter_eshop_id(fighter.name)
            common.show_eshop(eshop_id)
        end
    end
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