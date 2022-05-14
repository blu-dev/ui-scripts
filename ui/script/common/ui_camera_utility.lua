--[[
FILE: ui_camera_utility.lua
Reference Code: ui_camera_utility.lc

Author: blujay

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of ui_camera_utility.lc
when unmodified.
]]--

-- The actual object instance that gets returned (after setting it's metatable)
local object = {}

-- The actual utility object
local UiCameraUtility = {}

-- Class type for 3-element vectors
local Vector3 = {
    x = 0.0,
    y = 0.0,
    z = 0.0
}

-- Copies the specified vector into this vector
-- Args:
--  * `other`: the vector whose data should be copied
function Vector3:copy (other)
    self.x = other.x
    self.y = other.y
    self.z = other.z
end

-- Adds the specified vector to this vector and overwrites this one
-- Args:
--  * `other`: the vector whose data should be added
function Vector3:add (other)
    self.x = self.x + other.x
    self.y = self.y + other.y
    self.z = self.z + other.z
end

-- Subtracts the specified vector from this vector and overwrites this one
-- Args:
--  * `other`: the vector whose data should be subtracted
function Vector3:subtract (other)
    self.x = self.x - other.x
    self.y = self.y - other.y
    self.z = self.z - other.z
end

-- Multiplies the contents of this vector by a scalar and overwrites this one
-- Args:
--  * `scalar`: the scalar to multiply by
function Vector3:multiply_value (scalar)
    self.x = self.x * scalar
    self.y = self.y * scalar
    self.z = self.z * scalar
end

-- Gets the squared length of this vector
-- Returns:
--  The squared length of this vector
function Vector3:length_square ()
    return self.x * self.x + self.y * self.y + self.z * self.z
end

-- Creates a new, blank vector
local new_vector = function ()
    local object = {}
    return setmetatable(object, {
        __index = Vector3
    })
end

-- The default position of the camera
local default_position = new_vector()
default_position.x = 0.0
default_position.y = 7.5
default_position.z = 30.0

-- The default look at position of the camera
local default_look_at = new_vector()
default_look_at.x = 0.0
default_look_at.y = 7.5
default_look_at.z = 0.0

-- The default FOV of the camera
local default_fov = 0.66

local unit_scale              = 0.1         -- How much to scale the distance vectors by
local position_difference_min = 0.00001     -- The minimum difference in position in order to update
local fov_scale               = 0.1         -- FOV scale
local fov_difference_min      = 0.02        -- Minimum difference in position in order to update FOV

-- Sets the default positions of the camera (that happen on reset)
-- Args:
--  * `x`: the x position of the camera
--  * `y`: the y position of the camera, is also used as the default y look at position
--  * `z`: the z position of the camear
function UiCameraUtility:set_default_parameter (x, y, z)
    default_position.x = x
    default_position.y = y
    default_position.z = z
    default_look_at.y = y
end

-- Sends the current position of the camera to the application
function UiCameraUtility:send_parameter ()
    self:end_moving()
    if self.used_fov == true then
        UiFighterManager.set_camera_pos(self.position_.x, self.position_.y, self.position_.z, self.look_at_.x, self.look_at_.y, self.look_at_.z, self.fov)
    else
        UiFighterManager.set_menu_camera_pos(self.position_.x, self.position_.y, self.position_.z, self.look_at_.x, self.look_at_.y, self.look_at_.z)
    end
end

-- Sets the default position, look at, and FOV of the camera
function UiCameraUtility:set_default ()
    self.position_:copy(default_position)
    self.look_at_:copy(default_look_at)
    self.fov = default_fov
end

-- Sets the position of the camera
-- Args:
--  * `x`: the x position
--  * `y`: the y position
--  * `z`: the z position
function UiCameraUtility:set_position (x, y, z)
    self.position_.x = x
    self.position_.y = y
    self.position_.z = z
end

-- Sets the look at vector of the camera
-- Args:
--  * `x`: the x position
--  * `y`: the y position
--  * `z`: the z position
function UiCameraUtility:set_look_at (x, y, z)
    self.look_at_.x = x
    self.look_at_.y = y
    self.look_at_.z = z
end

-- Sets the FOV of the camera
-- Args:
--  * `fov`: The new FOV of the camera
function UiCameraUtility:set_fov (fov)
    self.fov = fov
    self.used_fov = true
end

-- Sets the camera to look at a fighter 
-- Args:
--  * `x`: the x offset
--  * `y`: the y offset
--  * `z`: the z offset
function UiCameraUtility:set_right_side_fighter (x, y, z)
    self:set_head_pos()
    self:set_waist_pos()
    self.position_.x = self.waist_pos_.x + x
    self.position_.y = (self.head_pos_.y + self.waist_pos_.y) * 0.5 + y
    self.position_.z = z
    self.look_at_.x = self.position_.x
    self.look_at_.y = self.position_.y
    self.fov = default_fov
end

-- Sets the camera to look at the head of a fighter
-- Args:
--  * `pos_x`: the x position offset
--  * `pos_y`: the y position offset
--  * `look_at_y`: the y look at offset
--  * `pos_z`: the z position offset
function UiCameraUtility:set_head_position_fighter (pos_x, pos_y, look_at_y, pos_z)
    self:set_head_pos()
    self.position_.x = self.head_pos_.x + pos_x
    self.position_.y = self.head_pos_.y + pos_y
    self.position_.z = pos_z
    self.look_at_.x = self.position_.x
    self.look_at_.y = self.head_pos_.y + look_at_y
    self.fov = default_fov
end

-- Retrieves the global head position if it hasn't been gotten yet
function UiCameraUtility:set_head_pos ()
    if self.head_pos_valid_ == false then
        self.head_pos_.x, self.head_pos_.y, self.head_pos_.z = UiFighterManager.get_global_head_pos(FIGHTER_ENTRY_ID_SELF)
        self.head_pos_valid_ = true
    end
end

-- Retrieves the global waist position if it hasn't been gotten yet
function UiCameraUtility:set_waist_pos ()
    if self.waist_pos_valid_ == false then
        self.waist_pos_.x, self.waist_pos_.y, self.waist_pos_.z = UiFighterManager.get_global_hip_n_pos(FIGHTER_ENTRY_ID_SELF)
        self.waist_pos_valid_ = true
    end
end

-- Checks if the camera is currently moving
function UiCameraUtility:is_moving ()
    return self.is_moving_
end

-- Sets the moving flag to true, enabling updates
function UiCameraUtility:start_moving ()
    self.is_moving_ = true
end

-- Finalizes the camera move, clearing the move flag and setting position/lookat/fov data
function UiCameraUtility:end_moving ()
    self.current_position_:copy(self.position_)
    self.current_look_at_:copy(self.look_at_)
    self.current_fov = self.fov
    self.is_moving_ = false
end

-- Initializes the camera with default fields
function UiCameraUtility:initialize ()
    self.is_moving_ = false
    self.current_position_ = new_vector()
    self.position_ = new_vector()
    self.position_:copy(default_position)
    self.current_look_at_ = new_vector()
    self.look_at_ = new_vector()
    self.look_at_:copy(default_look_at)
    self.current_fov = 0.0
    self.fov = default_fov
    self.calc_vector_ = new_vector()
    self.calc_fov = 0.0
    self.used_fov = false
    self.head_pos_ = new_vector()
    self.head_pos_valid_ = false
    self.waist_pos_ = new_vector()
    self.waist_pos_valid_ = false
end

-- Updates the camera and it's position, look at, and FOV
function UiCameraUtility:update ()
    if self.is_moving_ == false then
        return
    end
    if not UiFighterManager.is_ready() then
        return
    end

    local length = 0.0
    local moved_position = true
    local moved_look_at = true
    local changed_fov = true

    self.current_position_.x, self.current_position_.y, self.current_position_.z = UiFighterManager.get_camera_pos()
    self.calc_vector_:copy(self.position_)
    self.calc_vector_:subtract(self.current_position_)
    self.calc_vector_:multiply_value(unit_scale)
    length = self.calc_vector_:length_square()
    if length <= position_difference_min then
        self.current_position_:copy(self.position_)
        moved_position = false
    else
        self.current_position_:add(self.calc_vector_)
    end

    self.current_look_at_.x, self.current_look_at_.y, self.current_look_at_.z = UiFighterManager.get_camera_target()

    self.calc_vector_:copy(self.look_at_)
    self.calc_vector_:subtract(self.current_look_at_)
    self.calc_vector_:multiply_value(unit_scale)
    length = self.calc_vector_:length_square()
    if length <= position_difference_min then
        self.current_look_at_:copy(self.look_at_)
        moved_look_at = false
    else
        self.current_look_at_:add(self.calc_vector_)
    end

    if self.used_fov == true then
        self.current_fov = UiFighterManager.get_camera_fov()
        self.calc_fov_ = (self.fov - self.current_fov) * fov_scale
        length = self.calc_vector_:length_square()
        if length <= fov_difference_min then
            self.current_fov = self.fov
            changed_fov = false
        else
            self.current_fov = self.current_fov + self.calc_fov_
        end
    else
        changed_fov = true
    end

    if moved_position == false and moved_look_at == false and changed_fov == false then
        self.is_moving_ = false
    end
    
    if self.used_fov == true then
        UiFighterManager.set_camera_pos(self.current_position_.x, self.current_position_.y, self.current_position_.z, self.current_look_at_.x, self.current_look_at_.y, self.current_look_at_.z, self.current_fov)
    else
        UiFighterManager.set_menu_camera_pos(self.current_position_.x, self.current_position_.y, self.current_position_.z, self.current_look_at_.x, self.current_look_at_.y, self.current_look_at_.z)
    end
end

return setmetatable(object, {
    __index = UiCameraUtility
})
