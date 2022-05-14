--[[
FILE: ui_common.lua
Reference Code: ui_common.lc

Author: blujay

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of ui_common.lc
when unmodified.
]]--

-- The object that actually gets returned
local object = {}

-- The UI common object, which I suppose inherits from base type?
-- There's no type system in lua so lol
local ui_common = {}

-- Initializes the random engine for this UI object
-- CLOSURE_0
ui_common.init_random = function ()
    Randomizer.setup_no_sync_seed_from_date()
end

-- Gets a random float
-- Returns:
--  The random value
-- CLOSURE_1
ui_common.get_random = function ()
    local f = Randomizer.no_sync_getf(1.0)
    return f
end

-- Waits for the specified length
-- Args:
--  * `length`: How long to wait for (likely in frames)
-- CLOSURE_2
ui_common.wait = function (length)
    for i=1, length, 1 do
        coroutine.yield()
    end
end

-- Clamps a value between a minimum and maximum
-- Args:
--  * `value`: The value to clamp
--  * `min`: The minimum value in the range
--  * `max`: The maximum value in the range
-- Returns:
--  The clamped value
-- CLOSURE_3
ui_common.clamp = function (value, min, max)
    if min == max then
        return min
    end
    if max < min then
        max, min = min, max
    end

    if value < min then
        return min
    elseif max < value then
        return max
    end

    return value
end


-- Wraps a value between a minimum and a maximum
-- Args:
--  * `value`: The value to wrap
--  * `min`: The minimum value in the range
--  * `max`: The maximum value in the range
-- Returns:
--  The wrapped value
-- CLOSURE_4
ui_common.wrap = function (value, min, max)
    if min == max then
        return min
    end

    if max < min then
        max, min = min, max
    end

    local wrapped = math.fmod(value - min, max - min)
    if wrapped < 0 then
        wrapped = wrapped + max - min
    end
    return wrapped + min
end

-- Waits on an animation to finish
-- Args:
--  * `layout_view`: the layout that is managing the animation
--  * `anim_name`: the name of the animation
-- CLOSURE_5
ui_common.wait_animation = function (layout_view, anim_name)
    while not layout_view:is_animation_finished(anim_name) do
        coroutine.yield()
    end
end

-- Plays the animation of a sub-part of the layout
-- Args:
--  * `layout_view`: the layout that holds the part
--  * `parts`: the ID of the part to play the animation on
--  * `anim_name`: the name of the animation
-- CLOSURE_6
ui_common.parts_wait_animation = function (layout_view, parts, anim_name)
    while not layout_view:is_animation_finished_parts(parts, anim_name) do
        coroutine.yield()
    end
end

-- Waits on all animations in a list to finish
-- Args:
--  * `list`: List of animations to wait on (numeric indices only)
-- CLOSURE_7
ui_common.list_wait_animation = function (list)
    for index, anim in ipairs(list) do
        local layout_view = anim.parts_name and anim.layout_view:get_parts(anim.parts_name) or anim.layout_view
        ui_common.wait_animation(layout_view, anim.tag_name)
    end
end

-- Plays and waits on an animation
-- Args:
--  * `layout_view`: the layout that manages the animation
--  * `anim_name`: the name of the animation
-- CLOSURE_8
ui_common.play_animation_and_wait = function (layout_view, anim_name)
    layout_view:play_animation(anim_name, 1.0)
    ui_common.wait_animation(layout_view, anim_name)
end

-- Plays a reversed animation and waits on it
-- Args:
--  * `layout_view`: the layout that manages the animation
--  * `anim_name`: the name of the animation
-- CLOSURE_9
ui_common.reverse_animation_and_wait = function (layout_view, anim_name)
    layout_view:play_animation(anim_name, -1.0)
    ui_common.wait_animation(layout_view, anim_name)
end

-- Plays a sub-parts's animation and waits on it
-- Args:
--  * `layout_view`: the layout that holds the part
--  * `parts`: the ID of the part to play the animation on
--  * `anim_name`: the name of the animation
-- CLOSURE_10
ui_common.parts_play_animation_and_wait = function (layout_view, parts, anim_name)
    layout_view:play_animation_parts(parts, anim_name)
    ui_common.parts_wait_animation(layout_view, parts, anim_name)
end

-- Plays a list of animations and optionally waits on them
-- Args:
--  * `list`: the list of animations to play (numeric indices only)
--  * `should_wait`: whether or not to wait on the animations to finish
-- CLOSURE_11
ui_common.list_play_animation = function (list, should_wait)
    for index, anim in ipairs(list) do
        local layout_view = anim.parts_name and anim.layout_view:get_parts(anim.parts_name) or anim.layout_view
        layout_view:play_animation(anim.tag_name, 1)
    end
    if should_wait then
        ui_common.list_wait_animation(list)
    end
end

-- Gets the updated time counter (increasing)
-- Args:
--  * `current`: the current time counter
-- Returns:
--  The updated time counter (increasing)
-- CLOSURE_12
ui_common.add_time_counter = function (current)
    return current + FrameSkipManager.get_over_loop_times()
end

-- Gets the updated time counter (decreasing)
-- Args:
--  * `current`: the current time counter
-- Returns:
--  The updated time counter (decreasing)
-- CLOSURE_13
ui_common.sub_time_counter = function (current)
    return current - FrameSkipManager.get_over_loop_times()
end

-- Fades out and optionally waits
-- Args:
--  * `wait_for_finish`: whether to wait on the fade to finish
-- CLOSURE_14
ui_common.fade_out = function (wait_for_finish)
    FadeManager.fade_out()
    while wait_for_finish and not FadeManager.is_done() do
        coroutine.yield()
    end
end

-- Fades in and optionally waits
-- Args:
--  * `wait_for_finish`: whether to wait on the fade to finish
-- CLOSURE_15
ui_common.fade_in = function (wait_for_finish)
    FadeManager.fade_in()
    while wait_for_finish and not FadeManager.is_done() do
        coroutine.yield()
    end
end

-- Fades in and optionally waits
-- Args:
--  * `arg`:
--  * `wait_for_finish`: whether to wait on the fade to finish
-- CLOSURE_16
ui_common.fade_in_current = function (arg, wait_for_finish)
    FadeManager.fade_in_current(arg)
    while wait_for_finish and not FadeManager.is_done() do
        coroutine.yield()
    end
end

-- Plays an animation and fades in at the same time
-- Args:
--  * `layout_view`: the layout which manages the animation
--  * `anim_name`: the name of the animation
-- CLOSURE_17
ui_common.play_animation_and_fade_in = function (layout_view, anim_name)
    if FadeManager:is_faded() == true then
        FadeManager:fade_in()
    end
    layout_view:play_animation(anim_name, 1.0)
end

-- Plays an animation in reverse and fades in at the same time
-- Args:
--  * `layout_view`: the layout which manages the animation
--  * `anim_name`: the name of the animation
-- CLOSURE_18
ui_common.reverse_animation_and_fade_in = function (layout_view, anim_name)
    if FadeManager:is_faded() == true then
        FadeManager:fade_in()
    end
    layout_view:play_animation(anim_name, -1.0)
end

-- Plays an animation and fades out at the same time
-- Args:
--  * `layout_view`: the layout which manages the animation
--  * `anim_name`: the name of the animation
-- CLOSURE_19
ui_common.play_animation_and_fade_out = function (layout_view, anim_name)
    if FadeManager:is_faded() == false then
        FadeManager:fade_out()
    end
    layout_view:play_animation(anim_name, 1.0)
    repeat
        coroutine.yield()
    until FadeManager:is_done()
end

-- Plays an animation in reverse and fades out at the same time
-- Args:
--  * `layout_view`: the layout which manages the animation
--  * `anim_name`: the name of the animation
-- CLOSURE_20
ui_common.reverse_animation_and_fade_out = function (layout_view, anim_name)
    if FadeManager:is_faded() == false then
        FadeManager:fade_out()
    end
    layout_view:play_animation(anim_name, -1.0)
    repeat
        coroutine.yield()
    until FadeManager:is_done()
end

-- Shows the how-to-play guide
-- Args:
--  * `arg`:
-- CLOSURE_21
ui_common.show_howto = function (arg)
    HowToPlayUtility.show(arg)
    while HowToPlayUtility.is_showing() do
        coroutine.yield()
    end
end

return setmetatable(object, {
    __index = ui_common
})