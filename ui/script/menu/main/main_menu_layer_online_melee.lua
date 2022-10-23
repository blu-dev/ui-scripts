local value = {}

button:add_id("ONLINE_MELEE", "ANYONE", 1)
button:add_id("ONLINE_MELEE", "ROOM", 2)
button:add_id("ONLINE_MELEE", "PARALLEL", 3)
button:add_id("ONLINE_MELEE", "CONVENTION", 4)

function value:initialize()
    self.layout_root = LayoutRootList.main_menu
    self.layout_view = self.layout_root:get_root_view()
    self.virtual_input = self.layout_root:get_virtual_input()
    self.in_anim = "appear_online_melee"
    self.out_anim = "disappear_online_melee"
    self.header = {}
    self.header.layout_view = self.layout_view:get_parts("set_header_online_melee")
    self.selector = LayoutButtonSelector.new()
    self.selector_parts = "set_menu_online_melee"
    self.selector_name = "selector_0"
    self.selector_config = LayoutButtonSelectorConfig.new()
    self.selector_config.bring_front_on_select = true
    self.selector_config.directional_degree = 60
    self.selector_config.use_cursor_looping = false
    self.selector_config.is_unique_se = true
    self.selector_config.decide_se_label_code = "se_system_fixed_s"
    self.selector_config.cancel_se_label_code = "se_system_cancel"
    self.selector_config.cursor_se_label_code = "se_system_cursor_l"
    self.selector_initial_id = button.ONLINE_MELEE_ANYONE
    self.button_table = {}
    self.button_table[button.ONLINE_MELEE_ANYONE] = {
        parts = "set_parts_btn_00",
        sequence = SEQUENCE_ONLINE_MELEE_ANYONE
    }
    self.button_table[button.ONLINE_MELEE_ROOM] = {
        parts = "set_parts_btn_01",
        sequence = SEQUENCE_ONLINE_MELEE_ROOM
    }
    self.button_table[button.ONLINE_MELEE_PARALLEL] = {
        parts = "set_parts_btn_02",
        sequence = SEQUENCE_ONLINE_MELEE_WAIT_PARALLEL
    }
    self.button_table[button.ONLINE_MELEE_CONVENTION] = {
        parts = "set_parts_btn_03",
        sequence = SEQUENCE_ONLINE_MELEE_CONVENTION
    }
    self.footer_table = {}
    self.footer_table[button.ONLINE_MELEE_ANYONE] = {
        label = "mnu_onl_mel_top_help_any"
    }
    self.footer_table[button.ONLINE_MELEE_ROOM] = {
        label = "mnu_onl_mel_top_help_room"
    }
    self.footer_table[button.ONLINE_MELEE_PARALLEL] = {
        label = "mnu_onl_mel_top_help_parallel"
    }
    self.footer_table[button.ONLINE_MELEE_CONVENTION] = {
        label = "mnu_onl_mel_top_help_event_convention"
    }
    self.preview_table = {}
    self.preview_table.layout_view = self.layout_view:get_parts("set_menu_preview_on_m")
    self.preview_table[button.ONLINE_MELEE_ANYONE] = {
        tag = "select_anyone"
    }
    self.preview_table[button.ONLINE_MELEE_ROOM] = {
        tag = "select_room"
    }
    self.preview_table[button.ONLINE_MELEE_PARALLEL] = {
        tag = "select_parallel"
    }
    self.preview_table[button.ONLINE_MELEE_CONVENTION] = {
        tag = "select_convention"
    }
    self.howto_table = {}
    self.howto_table[button.ONLINE_MELEE_ANYONE] = {
        id = "UI_HOWTOPLAY_ANYONE_TOP"
    }
    self.howto_table[button.ONLINE_MELEE_ROOM] = {
        id = "UI_HOWTOPLAY_PRIVATE_ROOM_TOP"
    }
    self.howto_table[button.ONLINE_MELEE_PARALLEL] = {
        id = "UI_HOWTOPLAY_BACKGROUND_MATCH_TOP"
    }
end

function value:setup_selector()
    local is_elite = prg_func.is_valid_vip_match()
    local parts = self.layout_view:get_parts(self.selector_parts)
    local quickplay_parts = parts:get_parts(self.button_table[button.ONLINE_MELEE_ANYONE].parts)
    local bg_matchmaking = parts:get_parts(self.button_table[button.ONLINE_MELEE_PARALLEL].parts)
    local quickplay_elite = quickplay_parts:get_parts("set_parts_vip")
    local bg_elite = bg_matchmaking:get_parts("set_parts_vip")
    local animation = is_elite and "show" or "hide"
    common.play_animation_random(quickplay_elite, animation, true)
    common.play_animation_random(bg_elite, animation, true)
    local is_tourney = prg_func.is_enable_online_convention()
    local tourney_parts = parts:get_parts(self.button_table[button.ONLINE_MELEE_CONVENTION].parts)
    local tourney_button = self.selector:get_button(button.ONLINE_MELEE_CONVENTION)
    common.play_animation(tourney_parts, is_tourney and "show" or "hide")
    tourney_button:set_selectable(is_tourney)
    tourney_button:set_decidable(is_tourney)
    local is_tourney_enabled = prg_func.is_in_period_online_convention()
    common.play_animation(tourney_parts, is_tourney_enabled and "event_on" or "event_off")
end

function value:update_state_in()
    common.update_state_in(self)
    if state:is_first() then
        Network.sleep_parallel_matching()
        if prg_func.is_valid_vip_match() and not prg_func.is_unlock_vip_match() then
            prg_func.unlock_vip_match()
            common.wait_animation(self.layout_view, self.in_anim)
            AppPopupManager.open_database("ID_POPUP_ONL_MEL_TOP_UNLOCK_VIP")
        end
    end
end

function value:update_state_main()
    if Network:is_connected() == false then
        state:advance()
    end
    common.update_state_main(self)
end

function value:update_state_out()
    common.update_state_out(self)
end

return value