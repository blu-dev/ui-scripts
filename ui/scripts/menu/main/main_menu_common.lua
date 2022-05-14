--[[
FILE: main_menu_common.lua
Reference Code: main_menu_common.lc

Author: blujay

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of main_menu_common.lc
when unmodified.
]]--
-- The actual object to be returned
local common = {}

-- Updates the state of entering the main menu
-- Args:
--  * `selector`: the selector object
common.update_state_in = function (selector)
    if state:is_first() then
        common.show_howto_first()
        common.init_selector(selector)
        common.play_animation(selector.layout_view, selector.in_anim)
        if selector.header and selector.header.layout_view then
            common.play_animation(selector.header.layout_view, "anim_in")
        end
        if selector.preview_table and selector.preview_table.layout_view then
            common.play_animation(selector.preview_table.layout_view, "anim_in")
        end
        footer:disappear()
        if selector.banner then
            selector.banner:reset()
        end
        if selector.enable_screen_blur then
            UiGraphicsManager.begin_screen_blur()
        end
    end
    state:advance()
end

-- Updates the state of the main menu
-- Args:
--  * `selector`: the selector object
common.update_state_main = function (selector)
    if state:is_first() then
        footer:appear()
        common.exec_resume(selector)
    end

    footer:update(selector)
    if selector.virtual_input:is_pressed(INPUT_HOWTO) then
        if selector.howto_table then
            local howto_entry = selector.howto_table[selector.selector_id]
            if howto_entry and howto_entry.id then
                UiSoundManager:play_se_label("se_system_fixed")
                common.show_howto(howto_entry.id)
            end
        end
    elseif selector.selector_decide then
        if selector.button_table then
            local button_entry = selector.button_table[selector.selector_id]
            if button_entry then
                selector.layout_view:stop_animation_at_end(selector.in_anim)
                if button_entry.func_decide then
                    button_entry.func_decide(selector, button_entry.func_arg)
                end
                if button_entry.sequence then
                    if prg_func.is_invalid_online_sequence(button_entry.sequence) then
                        AppPopupManager.open_database("ID_POPUP_ONLINE_SERVICE_ERROR")
                        while AppPopupManager.is_busy() do
                            coroutine.yield()
                        end
                        return
                    end
                    if button_entry.sequence == SEQUENCE_ONLINE_SHARE and not prg_func.is_free_communication_permission() then
                        AppPopupManager.open_database("ID_POPUP_ONL_TOP_PARENTAL_CTRL_SHARE")
                        while AppPopupManager.is_busy() do
                            coroutine.yield()
                        end
                        return
                    end
                    RumbleManager.play(selector.virtual_input:get_last_input_device_id(), "RBKIND_UI_FIXED")
                    selector.layout_root:set_enable_input(false)
                    root_type = button_entry.sequence
                    state:set(STATE_TERM)
                elseif button_entry.state then
                    selector.layout_root:set_enable_input(false)
                    state:push(button_entry.state)
                end
            end
        end
    elseif selector.selector_cancel then
        state:advance()
    elseif common.get_input_lr(selector) ~= 0 then
        if selector.button_table then
            local button_entry = selector.button_table[selector.selector_id]
            if button_entry and button_entry.func_lr then
                button_entry.func_lr(selector, common.get_input_lr(selector) < 0)
            end
        end
    elseif selector.selector then
        if selector.selector:is_going_outside() then
            local ox, oy = selector.selector:get_outside_origin()
            local dx, dy = selector.selector:get_outside_direction()
            prg_func.open_pallet(ox, oy, dx, dy)
        end
    end
end

-- Updates the state of exiting the main menu
-- Args:
--  * `selector`: the selector object
common.update_state_out = function (selector)
    if state:is_first() then
        common.play_animation(selector.layout_view, selector.out_anim)
        footer:disappear()
        if selector.enable_screen_blur then
            UiGraphicsManager.end_screen_blur()
        end
    end
    if state:pop() then
        common.term_selector(selector)
    else
        root_type = SEQUENCE_TITLE
        state:set(STATE_TERM)
    end
end

-- Initializes the selector object
-- Args:
--  * `selector`: the selector object
common.init_selector = function (selector)
    if selector.selector then
        local layout_view = selector.layout_view
        if selector.selector_parts then
            layout_view = selector.layout_view:get_parts(selector.selector_parts)
        end
        selector.selector:setup(layout_view, selector.selector_name, selector.selector_config)
        for name, button in pairs(selector.button_table) do
            selector.selector:setup_button(name, button.parts)
        end

        selector.selector:set_enable(true)
        selector.selector:set_focus(true)
        selector.selector:select_button(selector.selector_initial_id, true)
        if selector.setup_selector then
            selector:setup_selector()
        end
    end
end

-- Updates the selector object
-- Args:
--  * `selector`: the selector object
common.update_selector = function (selector)
    if selector.selector and selector.selector:is_valid() then
        local selector_id = selector.selector_id
        selector.selector_id = selector.selector:get_selected_button_id()
        selector.selector_move = selector.selector_id ~= selector_id
        selector.selector_decide = selector.selector:get_decided_button_id() ~= BUTTON_ID_NONE
        selector.selector_cancel = selector.selector:is_cancelled()
        if selector.selector:is_enable() then
            prg_func.set_resume_button_id(selector.selector_id)
        end
    else
        selector.selector_id = BUTTON_ID_NONE
        selector.selector_move = false
        selector.selector_decide = false
        selector.selector_cancel = false
    end
end

-- Finalizes the selector object
-- Args:
--  * `selector`: the selector object
common.term_selector = function (selector)
    if selector.selector and selector.selector:is_valid() then
        selector.selector:release()
    end
end

-- Gets the input LR from the selector object
-- Args:
--  * `selector`: the selector object
common.get_input_lr = function (selector)
    local lr = 0
    if selector.virtual_input then
        if selector.virtual_input:is_pressed(INPUT_PREV) then
            lr = lr - 1
        end
        if selector.virtual_input:is_pressed(INPUT_NEXT) then
            lr = lr + 1
        end
    end
    return lr
end

-- Updates the preview of the main menu
-- Args:
--  * `selector`: the selector object
common.update_preview = function (selector)
    if selector.preview_table and selector.preview_table.layout_view and selector.selector_move then
        local preview = selector.preview_table[selector.selector_id]
        if preview and preview.tag then
            common.play_animation(selector.preview_table.layout_view, preview.tag, true)
            common.play_animation(selector.preview_table.layout_view, "anim_select")
        end
    end
end

-- Waits the specified number of frames
-- Args:
--  * `frames`: the number of frames to wait
common.wait = function (frames)
    for frame=1, frames, 1 do
        coroutine.yield()
    end
end

-- Plays the animation specified on the layouttu
-- Args:
--  * `layout_view`: the layout view to play the animation on
--  * `name`: the name of the animation
--  * `play_from_start`: if this is false, then it skips the animation
common.play_animation = function (layout_view, name, play_from_start)
    if resume and not play_from_start then
        common.skip_animation(layout_view, name)
    else
        layout_view:play_animation(name, 1)
    end
end

-- Plays the animation starting from a random frame
-- Args:
--  * `layout_view`: the layout view to play the animation on
--  * `name`: the name of the animation
--  * `play_from_start`: if this is false, then it skips the animation
common.play_animation_random = function (layout_view, name, play_from_start)
    common.play_animation(layout_view, name, play_from_start)
    local anim = layout_view:get_animation(name)
    local len = anim:get_length()
    if 0 < len then
        anim:set_frame(Randomizer.no_sync_get(len))
    end
end

-- Skips the specified animation
-- Args:
--  * `layout_view`: the layout view to skip the animation on
--  * `name`: the name of the animation
common.skip_animation = function (layout_view, name)
    layout_view:stop_animation_at_end(name)
end

-- Checks if an animation is finished
-- Args:
--  * `layout_view`: the layout view to check
--  * `name`: the name of the animation
-- Return:
--  If the animation is finished or not
common.is_animation_finished = function (layout_view, name)
    return layout_view:is_animation_finished(name)
end

-- Waits for an animation to finish
-- Args:
--  * `layout_view`: the layout view to wait on
--  * `name`: the name of the animation
common.wait_animation = function (layout_view, name)
    while not common.is_animation_finished(layout_view, name) do
        coroutine.yield()
    end
end

-- Shows the how-to-play guide for the specified ID
-- Args:
--  * `id`: the id of the how-to-play guide
common.show_howto = function (id)
    HowToPlayUtility.show(id)
    while HowToPlayUtility.is_showing() do
        coroutine.yield()
    end
end

-- Shows the first how-to-play guide for a state/sequence
common.show_howto_first = function ()
    if resume then
        return
    end

    local how_to_play_ids = {
        { state    = STATE_KUMITE_IN                    , howto_id = "UI_HOWTOPLAY_KUMITE_1"            },
        { state    = STATE_HOMERUN_IN                   , howto_id = "UI_HOWTOPLAY_HOMERUN_1"           },
        { sequence = SEQUENCE_MELEE_NORMAL              , howto_id = "UI_HOWTOPLAY_MELEE_NORMAL_1"      },
        { sequence = SEQUENCE_MELEE_TEAM_COMPE          , howto_id = "UI_HOWTOPLAY_TEAM_COMPE_1"        },
        { sequence = SEQUENCE_MELEE_SPECIAL_ALL_BATTLE  , howto_id = "UI_HOWTOPLAY_ALL_BATTLE_1"        },
        { sequence = SEQUENCE_MELEE_TOURNAMENT          , howto_id = "UI_HOWTOPLAY_TOURNAMENT_1"        },
        { sequence = SEQUENCE_SPIRITS_CHALLENGE         , howto_id = "UI_HOWTOPLAY_SPIRITS_BOARD_1"     },
        { sequence = SEQUENCE_SPIRITS_CHALLENGE_SPECIAL , howto_id = "UI_HOWTOPLAY_DLC_BOARD_1"         },
        { sequence = SEQUENCE_OTHER_STANDARD            , howto_id = "UI_HOWTOPLAY_STANDARD_1"          },
        { sequence = SEQUENCE_OTHER_CHARA_MAKE          , howto_id = "UI_HOWTOPLAY_MIIFIGHTER_1"        },
        { sequence = SEQUENCE_OTHER_AMIIBO              , howto_id = "UI_HOWTOPLAY_AMIIBO_1"            },
        { sequence = SEQUENCE_OTHER_CHALLENGER          , howto_id = "UI_HOWTOPLAY_CHALLENGER_1"        },
        { sequence = SEQUENCE_OTHER_STAGE_MAKE          , howto_id = "UI_HOWTOPLAY_STAGE_BUILDER_1"     },
        { sequence = SEQUENCE_OTHER_VR                  , howto_id = "UI_HOWTOPLAY_VR_MELEE_1"          },
        { sequence = SEQUENCE_COLLECTION_REPLAY_DATA    , howto_id = "UI_HOWTOPLAY_REPLAY_1"            },
        { sequence = SEQUENCE_COLLECTION_REPLAY_EDIT    , howto_id = "UI_HOWTOPLAY_EDIT_MOVIE_1"        },
        { sequence = SEQUENCE_ONLINE_MELEE_ANYONE       , howto_id = "UI_HOWTOPLAY_ANYONE_1"            },
        { sequence = SEQUENCE_ONLINE_MELEE_ROOM         , howto_id = "UI_HOWTOPLAY_PRIVATE_ROOM_1"      },
        { sequence = SEQUENCE_ONLINE_MELEE_WAIT_PARALLEL, howto_id = "UI_HOWTOPLAY_BACKGROUND_MATCH_1"  },
        { sequence = SEQUENCE_ONLINE_MELEE_TOURNAMENT   , howto_id = "UI_HOWTOPLAY_ONLINE_TOURNAMENT_1" },
        { sequence = SEQUENCE_ONLINE_WATCH              , howto_id = "UI_HOWTOPLAY_SPECTATE_1"          },
        { sequence = SEQUENCE_ONLINE_SHARE              , howto_id = "UI_HOWTOPLAY_EVERYONES_POST_1"    }
    }

    for index, id in ipairs(how_to_play_ids) do
        if (id.state and state:is(id.state)) or (id.sequence and root_type == id.sequence) then
            common.show_howto(id.howto_id)
            break
        end
    end
end

-- Shows the eshop with the specified id
-- Args:
--  * `id`: the id
common.show_eshop = function (id)
    if type(id) ~= "nil" then
        EShopManager.show_id(id)
    else
        EShopManager.show()
    end

    while EShopManager.is_busy() do
        coroutine.yield()
    end
end

-- Executes the main menu
-- Args:
--  * `selector`: the selector object
common.exec_resume = function (selector)
    if resume and selector.button_table then
        local masks = {
            0xFF,
            0xFFFF,
            0xFFFFFF,
            0xFFFFFFFF
        }

        for index, mask in ipairs(masks) do
            local masked_id = resume_button_id & mask
            if selector.button_table[masked_id] then
                if selector.selector and selector.selector:is_valid() then
                    selector.selector:select_button(masked_id, true)
                end
                selector.selector_id = masked_id
                selector.selector_move = true
                selector.selector_decide = masked_id ~= resume_button_id
                selector.selector_cancel = false
                if not selector.selector_decide then
                    resume = nil
                end
                return
            end

        end
    end

    resume = nil
end

return common