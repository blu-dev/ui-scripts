--[[
FILE: amiibo_camera.lua
Reference Code: amiibo_camera.lc

Author: jozz

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of amiibo_camera.lc
when unmodified.
]]--

-- The make_mii module
local make_mii = UiScriptPlayer.require("menu/chara_make/make_mii_utility")
-- The ui_camera module
local ui_camera = UiScriptPlayer.require("common/ui_camera_utility")
-- The ui_common module
local ui_common = UiScriptPlayer.require("common/ui_common")

-- The X value for the appear position type
local appear_x = 0.0
-- The X value for the top position type
local top_x = -3.5
-- The X value for the customize position type
local customize_x = -6.0
-- The X value for the raise position type
local raise_x = 18.0
-- The X value for the Prize position type (CAMERA_POSITION_TYPE_PRIZE)
local prize_x = 16.0
-- The Y position used for moving the camera
local pos_y = 15.0
-- The Z position used for moving the camera
local pos_z = 180.0
-- The Y position used for setting the look at values in ui_camera
local look_at_y = 12.399999618530273
-- The Z position used for setting the look at values in ui_camera
local look_at_z = 9.0

-- The amiibo_camera.state types
-- The stopped state (camera isnt moving)
local state_stopped = 0
-- The moving state (gets set to this when moving the camera in some way)
local state_move = 1
-- The mii editor state (only gets used when editing mii hat and gear) (i am not 100% on this)
local state_mii_edit = 2

-- The amiibo_camera.update_type types (say that 5 times fast)
-- None (when first initialized it is set to 0, so we can assume it is no-update)
local update_type_none = 0
-- The smooth state, used for a smooth transition between items
local update_type_smooth = 1
-- The immediate state, used for an immediate transition between items
local update_type_immediate = 2

-- amiibo_camera only has these children:
--    state
--    update_type
--    position_type
local amiibo_camera = {}

-- the initialize function for amiibo_camera
initialize = function ()
    -- set the state to stopped on initialization
    amiibo_camera.state = state_stopped
    -- set the update type to none
    amiibo_camera.update_type = update_type_none
    -- set the position type to appear (appear == entering the menu?)
    amiibo_camera.position_type = CAMERA_POSITION_TYPE_APPEAR
    -- initialize ui_camera
    ui_camera:initialize()
end

-- function to set the position_type, and the update type to smooth
set_position_smooth = function (position_type)
    -- Set the state to the moving state
    amiibo_camera.state = state_move
    -- Set the update type to smooth
    amiibo_camera.update_type = update_type_smooth
    -- Set the position type to the given position type
    amiibo_camera.position_type = position_type
end

-- function to set the position_type, and the update type to immediate
set_position_immediate = function (position_type)
    -- Set the state to the moving state
    amiibo_camera.state = state_move
    -- Set the update type to the immediate update type
    amiibo_camera.update_type = update_type_immediate
    -- Set the position type to the given position type
    amiibo_camera.position_type = position_type
end

-- This function moves the camera to the x value provided
local move_camera_to_x = function (x)
    -- If amiibo camera's update type is immediate
    if amiibo_camera.update_type == update_type_immediate then
        -- Use UiFighterManager to set the camera position to the given values
        UiFighterManager.set_menu_camera_pos(x, pos_y, pos_z, x, look_at_y, look_at_z)
        -- Set the camera state to stopped
        amiibo_camera.state = state_stopped
        -- End the camera moving
        ui_camera:end_moving()
    else
        -- Set the state to the mii editing state
        amiibo_camera.state = state_mii_edit
        -- Start moving
        ui_camera:start_moving()
    end
    -- Set the camera position to the current x, and our hardcoded y and z values
    ui_camera:set_position(x, pos_y, pos_z)
    -- Set the camera's look at position to the current x, and our hardcoded y and z values
    ui_camera:set_look_at(x, look_at_y, look_at_z)
end

-- function to update the camera to the current amiibo_camera values
update_camera = function ()
    -- If the amiibo camera's state is moving
    if amiibo_camera.state == state_move then
        -- If the position type is the mii hat editor
        if amiibo_camera.position_type == CAMERA_POSITION_MII_HAT then
            -- Set the mii head position using the fighter camera
            make_mii:set_head_position_fighter_camera(ui_camera)
            -- Start moving the camera
            ui_camera:start_moving()
            -- Set the amiibo camera state to the mii editor
            amiibo_camera.state = state_mii_edit

        -- If the position type is the mii skin editor
        elseif amiibo_camera.position_type == CAMERA_POSITION_MII_BODY then
            -- unsure what this does
            make_mii:set_right_side_1_fighter_camera(ui_camera, EDIT_MII_TYPE)
            -- Start moving the camera
            ui_camera:start_moving()
            -- Set the state to the mii editing state
            amiibo_camera.state = state_mii_edit

        -- If the position type is APPEAR
        elseif amiibo_camera.position_type == CAMERA_POSITION_APPEAR then
            -- Move the camera to the appear type's X value
            move_camera_to_x(appear_x)

        -- If the position type is TOP
        elseif amiibo_camera.position_type == CAMERA_POSITION_TOP then
            -- Move the camera to the top type's X value
            move_camera_to_x(top_x)

        -- If the position type is CUSTOMIZE
        elseif amiibo_camera.position_type == CAMERA_POSITION_CUSTOMIZE then
            -- Move the camera to the customize type's X value
            move_camera_to_x(customize_x)

        -- If the position type is RAISE
        elseif amiibo_camera.position_type == CAMERA_POSITION_RAISE then
            -- Move the camera to the raise type's X value
            move_camera_to_x(raise_x)

        -- If the position type is PRIZE
        elseif amiibo_camera.position_type == CAMERA_POSITION_PRIZE then
            -- Move the camera to the prize type's X value
            move_camera_to_x(prize_x)

        -- Otherwise, return
        else
            return
        end
    end
    -- Update the camera
    ui_camera:update()

    -- If the camera isnt moving
    if ui_camera:is_moving() == false then
        -- Set the state to stopped
        amiibo_camera.state = state_stopped
    end
end
