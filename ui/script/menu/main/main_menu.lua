local main_menu = {}
state = UiScriptPlayer.require("common/state_function")
STATE_TOP_IN = 1
STATE_TOP = 2
STATE_TOP_OUT = 3
STATE_MELEE_IN = 4
STATE_MELEE = 5
STATE_MELEE_OUT = 6
STATE_SPIRITS_IN = 7
STATE_SPIRITS = 8
STATE_SPIRITS_OUT = 9
STATE_OTHER_IN = 10
STATE_OTHER = 11
STATE_OTHER_OUT = 12
STATE_COLLECTION_IN = 13
STATE_COLLECTION = 14
STATE_COLLECTION_OUT = 15
STATE_ONLINE_IN = 16
STATE_ONLINE = 17
STATE_ONLINE_OUT = 18
STATE_SPECIAL_IN = 19
STATE_SPECIAL = 20
STATE_SPECIAL_OUT = 21
STATE_KUMITE_IN = 22
STATE_KUMITE = 23
STATE_KUMITE_OUT = 24
STATE_REPLAY_IN = 25
STATE_REPLAY = 26
STATE_REPLAY_OUT = 27
STATE_RECORD_IN = 28
STATE_RECORD = 29
STATE_RECORD_OUT = 30
STATE_ONLINE_MELEE_IN = 31
STATE_ONLINE_MELEE = 32
STATE_ONLINE_MELEE_OUT = 33
STATE_DLC_IN = 34
STATE_DLC = 35
STATE_DLC_OUT = 36
STATE_HOMERUN_IN = 37
STATE_HOMERUN = 38
STATE_HOMERUN_OUT = 39
STATE_TERM = 99

common = UiScriptPlayer.require("menu/main/main_menu_common")
button = UiScriptPlayer.require("menu/main/main_menu_button")
footer = UiScriptPlayer.require("menu/main/main_menu_footer")
information = UiScriptPlayer.require("menu/main/main_menu_information")
resume_button_id = 0
dlc_fighter_list = {}
finish_requested = false
is_in_top = false
local top = UiScriptPlayer.require("menu/main/main_menu_layer_top")
local melee = UiScriptPlayer.require("menu/main/main_menu_layer_melee")
local spirits = UiScriptPlayer.require("menu/main/main_menu_layer_spirits")
local other = UiScriptPlayer.require("menu/main/main_menu_layer_other")
local collection = UiScriptPlayer.require("menu/main/main_menu_layer_collection")
local online = UiScriptPlayer.require("menu/main/main_menu_layer_online")
local special = UiScriptPlayer.require("menu/main/main_menu_layer_special")
local kumite = UiScriptPlayer.require("menu/main/main_menu_layer_kumite")
local replay = UiScriptPlayer.require("menu/main/main_menu_layer_replay")
local record = UiScriptPlayer.require("menu/main/main_menu_layer_record")
local online_melee = UiScriptPlayer.require("menu/main/main_menu_layer_online_melee")
local dlc = UiScriptPlayer.require("menu/main/main_menu_layer_dlc")
local homerun = UiScriptPlayer.require("menu/main/main_menu_layer_homerun")
local bg_anim = UiScriptPlayer.require("menu/common/com_bg_anim")

local co = coroutine.create(
    function()
        while true do
            state:update()
            is_in_top = false
            if state:get() == STATE_TOP then
                is_in_top = true
            end
            coroutine.yield()
        end
    end
)

function main_menu:initialize()
    for i, root in ipairs(LayoutRootList) do
        root:set_enable_input(false)
    end

    dlc_fighter_list = prg_func.get_dlc_fighter_list()
    is_in_top = false

    state:setup(STATE_TOP_IN, top, top.update_state_in, "STATE_TOP_IN")
    state:setup(STATE_TOP, top, top.update_state_main, "STATE_TOP")
    state:setup(STATE_TOP_OUT, top, top.update_state_out, "STATE_TOP_OUT")
    state:setup(STATE_MELEE_IN, melee, melee.update_state_in, "STATE_MELEE_IN")
    state:setup(STATE_MELEE, melee, melee.update_state_main, "STATE_MELEE")
    state:setup(STATE_MELEE_OUT, melee, melee.update_state_out, "STATE_MELEE_OUT")
    state:setup(STATE_SPIRITS_IN, spirits, spirits.update_state_in, "STATE_SPIRITS_IN")
    state:setup(STATE_SPIRITS, spirits, spirits.update_state_main, "STATE_SPIRITS")
    state:setup(STATE_SPIRITS_OUT, spirits, spirits.update_state_out, "STATE_SPIRITS_OUT")
    state:setup(STATE_OTHER_IN, other, other.update_state_in, "STATE_OTHER_IN")
    state:setup(STATE_OTHER, other, other.update_state_main, "STATE_OTHER")
    state:setup(STATE_OTHER_OUT, other, other.update_state_out, "STATE_OTHER_OUT")
    state:setup(STATE_COLLECTION_IN, collection, collection.update_state_in, "STATE_COLLECTION_IN")
    state:setup(STATE_COLLECTION, collection, collection.update_state_main, "STATE_COLLECTION")
    state:setup(STATE_COLLECTION_OUT, collection, collection.update_state_out, "STATE_COLLECTION_OUT")
    state:setup(STATE_ONLINE_IN, online, online.update_state_in, "STATE_ONLINE_IN")
    state:setup(STATE_ONLINE, online, online.update_state_main, "STATE_ONLINE")
    state:setup(STATE_ONLINE_OUT, online, online.update_state_out, "STATE_ONLINE_OUT")
    state:setup(STATE_SPECIAL_IN, special, special.update_state_in, "STATE_SPECIAL_IN")
    state:setup(STATE_SPECIAL, special, special.update_state_main, "STATE_SPECIAL")
    state:setup(STATE_SPECIAL_OUT, special, special.update_state_out, "STATE_SPECIAL_OUT")
    state:setup(STATE_KUMITE_IN, kumite, kumite.update_state_in, "STATE_KUMITE_IN")
    state:setup(STATE_KUMITE, kumite, kumite.update_state_main, "STATE_KUMITE")
    state:setup(STATE_KUMITE_OUT, kumite, kumite.update_state_out, "STATE_KUMITE_OUT")
    state:setup(STATE_REPLAY_IN, replay, replay.update_state_in, "STATE_REPLAY_IN")
    state:setup(STATE_REPLAY, replay, replay.update_state_main, "STATE_REPLAY")
    state:setup(STATE_REPLAY_OUT, replay, replay.update_state_out, "STATE_REPLAY_OUT")
    state:setup(STATE_RECORD_IN, record, record.update_state_in, "STATE_RECORD_IN")
    state:setup(STATE_RECORD, record, record.update_state_main, "STATE_RECORD")
    state:setup(STATE_RECORD_OUT, record, record.update_state_out, "STATE_RECORD_OUT")
    state:setup(STATE_ONLINE_MELEE_IN, online_melee, online_melee.update_state_in, "STATE_ONLINE_MELEE_IN")
    state:setup(STATE_ONLINE_MELEE, online_melee, online_melee.update_state_main, "STATE_ONLINE_MELEE")
    state:setup(STATE_ONLINE_MELEE_OUT, online_melee, online_melee.update_state_out, "STATE_ONLINE_MELEE_OUT")
    state:setup(STATE_DLC_IN, dlc, dlc.update_state_in, "STATE_DLC_IN")
    state:setup(STATE_DLC, dlc, dlc.update_state_main, "STATE_DLC")
    state:setup(STATE_DLC_OUT, dlc, dlc.update_state_out, "STATE_DLC_OUT")
    state:setup(STATE_HOMERUN_IN, homerun, homerun.update_state_in, "STATE_HOMERUN_IN")
    state:setup(STATE_HOMERUN, homerun, homerun.update_state_main, "STATE_HOMERUN")
    state:setup(STATE_HOMERUN_OUT, homerun, homerun.update_state_out, "STATE_HOMERUN_OUT")
    state:setup(STATE_TERM, self, self.update_state_term, "STATE_TERM")
    state:set_callback(self, self.init_state)
    self.layers = {
        top,
        melee,
        spirits,
        other,
        collection,
        online,
        special,
        kumite,
        replay,
        record,
        online_melee,
        dlc,
        homerun
    }
    for i, layer in ipairs(self.layers) do
        if layer.initialize then
            layer:initialize()
        end
    end
    self.input_layer = {}
    self.input_layer[STATE_TOP] = top
    self.input_layer[STATE_MELEE] = melee
    self.input_layer[STATE_SPIRITS] = spirits
    self.input_layer[STATE_OTHER] = other
    self.input_layer[STATE_COLLECTION] = collection
    self.input_layer[STATE_ONLINE] = online
    self.input_layer[STATE_SPECIAL] = special
    self.input_layer[STATE_KUMITE] = kumite
    self.input_layer[STATE_REPLAY] = replay
    self.input_layer[STATE_RECORD] = record
    self.input_layer[STATE_ONLINE_MELEE] = online_melee
    self.input_layer[STATE_DLC] = dlc
    self.input_layer[STATE_HOMERUN] = homerun

    footer:initialize()
    information:initialize()

    self.anim_id = {}
    self.anim_id[button.MELEE] = ANIM_MODULE_MELEE
    self.anim_id[button.SPIRITS] = ANIM_MODULE_SPIRITS
    self.anim_id[button.OTHER] = ANIM_MODULE_OTHER
    self.anim_id[button.COLLECTION] = ANIM_MODULE_COLLECTION
    self.anim_id[button.ONLINE] = ANIM_MODULE_ONLINE
    self.anim_id[button.ESHOP] = ANIM_MODULE_ESHOP

    local root_view = LayoutRootList.main_menu:get_root_view()

    for button, id in pairs(self.anim_id) do
        bg_anim:initialize(root_view, id)
    end

    state:set(STATE_TOP_IN)
    local resume_button = prg_func.get_resume_button_id()
    if resume_button & 0xFF == button.ONLINE and button:get_layer(resume_button) > 1 and not Network:is_connected() then
        prg_func.set_resume_button_id(0)
        prg_func.set_sequence_online(false)
    end
    resume_button_id = prg_func.get_resume_button_id()
    if resume_button_id ~= 0 then
        resume = true
        while resume do
            self:update()
        end
    end
end

function main_menu:finalize()
    for i, root in ipairs(LayoutRootList) do
        root:set_enable_input(false)
    end

    for i, layer in ipairs(self.layers) do
        if layer.finalize then
            layer:finalize()
        end
    end

    footer:finalize()
    information:finalize()
    for button, id in pairs(self.anim_id) do
        bg_anim:finalize(id)
    end

    UiGraphicsManager.end_screen_blur()
end

function main_menu:update()
    self:pre_update()
    coroutine.resume(co)
    coroutine.resume(information.co_update)
    self:post_update()
end

function main_menu:pre_update()
    for i, layer in ipairs(self.layers) do
        common.update_selector(layer)
    end
end

function main_menu:post_update()
    for i, layer in ipairs(self.layers) do
        common.update_preview(layer)
    end

    if state:module() and state:module().banner then
        state:module().banner:update()
    end

    if self.anim_id[top.selector_id] then
        bg_anim:update(self.anim_id[top.selector_id])
    end
end

function main_menu:init_state()
    print_log(state:name())
    for i, root in ipairs(LayoutRootList) do
        local layer = self.input_layer[state:get()]
        local should_enable = false
        if layer then
            should_enable = root == layer.layout_root
        end
        root:set_enable_input(should_enable)
    end
    for i, layer in ipairs(self.layers) do
        if layer.selector and layer.selector:is_valid() then
            local state_layer = self.input_layer[state:get()]
            local should_enable = false
            if state_layer then
                should_enable = layer == state_layer
            end
            layer.selector:set_enable(should_enable)
        end
    end
end

function main_menu:update_state_term()
    if state:is_first() then
        FadeManager.fade_out()
    elseif FadeManager.is_done() then
        common.show_howto_first()
        state:advance()
    end
end

function main()
    exit_code = SCENE_EXIT_CODE_NONE
    main_menu:initialize()
    repeat
        main_menu:update()
        coroutine.yield()
        if state:get() > STATE_TERM then
            break
        end
    until finish_requested
    main_menu:finalize()
    exit_code = SCENE_EXIT_CODE_NORMAL
end

function finish()
    finish_requested = true
end