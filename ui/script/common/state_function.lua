--[[
FILE: state_function.lua
Reference Code: state_function.lc

Author: blujay

Notes: The following code has been decompiled with the assistance of a modified
binary of the DSLuaDecompiler to produce *some* output, while not very meaningful it helps
outline the structure of some functions so that the disassembled lua could be used
as a reference instead of the guiding light

The following code was all written by hand, and was compiled via https://github.com/ultimate-research/smash-lua
and disassembled using https://github.com/jam1garner/smash-luadec

The output disassembly of this file is guaranteed to match exactly that of state_function.lc
when unmodified.
]]--

-- The actual state function object (returned at end of function)
local state_function = { 
    state_ = nil,
    prev_ = nil,
    next_ = nil,
    stack_ = {},
    count_ = 0,
    funcs_ = {},
    init_ = nil,
    current_ = nil
}

-- Calls a state function with the specified arguments
-- Args:
--  * `module_`: the module that this function is a part of. Can be `nil`
--  * `func`: the state function to call. Cannot be `nil`
--  * `...`: the remaining arguments to be passed along to the state function
-- CLOSURE_0
local call_state_function = function(module_, func, ...)
    if func then
        if module_ then
            func(module_, ...)
        else
            func(...)
        end
    end
end

-- Creates a function with the specified index in the function table
-- Args:
--  * `index`: the index into the function table
--  * `module_`: the function's module. Can be `nil`
--  * `func_`: the function. Cannot be `nil`
--  * `name`: the name of the function
-- CLOSURE_1
function state_function:setup (index, module_, func_, name)
    self.funcs_[index] = {
        module_ = module_,
        func_ = func_,
        name_ = name
    }
end

-- Sets the state initialization callback
-- Args:
--  * `module_`: the function's module. Can be `nil`
--  * `func_`: the callback function. Cannot be `nil`
-- CLOSURE_2
function state_function:set_callback (module_, func_)
    self.init_ = {
        module_ = module_,
        func_ = func_
    }
end

-- Gets the current state
-- CLOSURE_3
function state_function:get ()
    return self.state_
end

-- Gets the last state
-- CLOSURE_4
function state_function:last_state ()
    return self.prev_
end

-- Gets the number of times this state function has updated
-- CLOSURE_5
function state_function:count ()
    return self.count_
end

-- Gets the module of the current state
-- CLOSURE_6
function state_function:module ()
    if self.current_ then
        return self.current_.module_
    end
    return nil
end

-- Gets the name of the current state
-- CLOSURE_7
function state_function:name ()
    if self.current_ then
        return self.current_.name_
    end
    return nil
end

-- Sets the next state
-- Args:
--  * `next_state`: the state to change to on the next update
-- CLOSURE_8
function state_function:set (next_state)
    self.next_ = next_state
end

-- Advances to the next state by adding one to the current state
-- CLOSURE_9
function state_function:advance ()
    self:set(self:get() + 1)
end

-- Pushes a state onto the state stack
-- Args:
--  * `next_state`: the state to change to on the next update
-- CLOSURE_10
function state_function:push (next_state)
    self.next_ = next_state
    self.stack_[#self.stack_ + 1] = self.state_
end

-- Pops a state from the state stack into onto the next state
-- Returns:
--  Whether or not it was able to pop a state
-- CLOSURE_11
function state_function:pop ()
    if #self.stack_ > 0 then
        self.next_ = self.stack_[#self.stack_]
        self.stack_[#self.stack_] = nil
        return true
    end
    return false
end

-- Compares the state provided with the current state
-- Args:
--  * `state`: the state to check against
-- Returns:
--  Whether the provided state is the current state
-- CLOSURE_12
function state_function:is (state)
    return self:get() == state
end

-- Checks if this is the first time this function has been run on the current state
-- Returns:
--  Whether or not this is the first time the function has run on the current state
-- CLOSURE_13
function state_function:is_first ()
    return self:count() == 0
end

-- Updates the current state function
-- Args:
--  * `...`: all args to be passed along to the state function
-- CLOSURE_14
function state_function:update(...)
    -- check if we have a new state to transition to
    if self.next_ then
        -- if it's not the current state then we can switch over
        if self.next_ ~= self.state_ then
            -- push our current state onto the previous state,
            -- then setup for the next one and call init callback if it exists
            self.prev_ = self.state_
            self.state_ = self.next_
            self.current_ = self.funcs_[self.state_]
            if self.init_ then
                call_state_function(self.init_.module_, self.init_.func_)
            end
            self.count_ = 0
        end
        self.next_ = nil
    end

    -- run the current function
    if self.current_ then
        call_state_function(self.current_.module_, self.current_.func_, ...)
    end

    self.count_ = self.count_ + 1
end

return state_function