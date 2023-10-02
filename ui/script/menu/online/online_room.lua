--[[
FILE: online_room.lua
Reference Code: online_room.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of online_room.lc
when unmodified.
]]--

-- The online room variable
local online_room = {}
-- The ui_common module
local ui_common = UiScriptPlayer.require("common/ui_common")
-- The state_function module
local state_function = UiScriptPlayer.require("common/state_function")

-- States
-- State in
local state_in = 1
-- State main
local state_main = 2
-- State out
local state_out = 3
-- State term
local state_term = 99


online_buddy_close = function (code)
    -- If the current state isn't state_out
    if state_function:is(state_out) == false then
        -- Set the exit code to the variable given
        exit_code = code
        -- Set the current state to state_out
        state_function:set(state_out)
    end
end

-- Coroutine for updating the state function
local update_coro = coroutine.create(function ()
    while true do
        state_function:update()
        coroutine.yield()
    end
end
)


function online_room:initialize ()
    -- Set the exit code to none
    exit_code = SCENE_EXIT_CODE_NONE
    -- Set the layout root to online_buddy
    self.layout_root = LayoutRootList.online_buddy
    -- Set the layout view by getting the root view from layout_root
    self.layout_view = self.layout_root:get_root_view()
    -- Set the virtual input by getting the virtual input from layout_root
    self.virtual_input = self.layout_root:get_virtual_input()
    -- Show the online bg
    ComBgActor:show_bg(COMBG_KIND_ONLINE)
    -- Hide the frame
    ComFrameActor:hide_frame()

    -- Setup the in state
    state_function:setup(state_in, self, self.update_state_in)
    -- Setup the main state
    state_function:setup(state_main, self, self.update_state_main)
    -- Setup the out state
    state_function:setup(state_out, self, self.update_state_out)
    -- Setup the term state
    state_function:setup(state_term, self, self.update_state_term)

    -- Set the current state to in
    state_function:set(state_in)
end

function online_room:finalize ()
    -- Empty
end

function online_room:update ()
    -- Resume the update coroutine
    coroutine.resume(update_coro)
end

function online_room:update_state_in ()
    -- Play the slide in anim
    ui_common.play_animation_and_fade_in(self.layout_view, "slide_in")
    
    -- Set the current state to the main state
    state_function:set(state_main)
end

function online_room:update_state_main ()
    -- empty
end

function online_room:update_state_out ()
    -- Play the slide out anim
    ui_common.play_animation_and_fade_out(self.layout_view, "slide_out")
    state_function:set(state_term)
end

function online_room:update_state_term ()
    -- Advance to the next state state
    state_function:advance()
end

main = function ()
    -- Initialize online_room
    online_room:initialize()
    -- Loop
    repeat
        -- Update online_room
        online_room:update()
        -- Yield coroutine
        coroutine.yield()
    -- Repeat until the current state is greater than the index of the term state
    until state_function:get() > state_term
    -- Finalize the online room
    online_room:finalize()
end
