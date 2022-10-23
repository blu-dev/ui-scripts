local value = {}

function value:initialize()
    self.layout_root = LayoutRootList.main_menu
    self.layout_view = self.layout_root:get_root_view():get_parts("set_parts_text_scroll")
    self.main_pane = self.layout_view:get_pane("set_txt_main")
    self.mask_pane = self.layout_view:get_pane("set_txt_mask")
    self.main_pane:clear_text_string()
    self.mask_pane:clear_text_string()
    self.data = actor:get_information_data()
    if #self.data == 0 then
        self.data = {
            "mnu_top_notices_space",
            "mnu_top_notices_connect_net_latest_info",
            "mnu_top_notices_smashbros"
        }
    end
    self.layout_view:set_text_scroll_moving_speed(4)
    self.layout_view:set_text_scroll_force_scroll(true)
    self.layout_view:set_text_scroll_through_mode(true)
    self.layout_view:set_text_scroll_loop_enabled(false)
end

function value:finalize()
end

function value:update()
    while true do
        for i, val in ipairs(self.data) do
            self.main_pane:set_text_message(val)
            self.mask_pane:set_text_message(val)
            self.layout_view:reset_text_scroll_location()
            self.layout_view:stop_text_scroll_animation()
            common.wait(100)
            self.layout_view:play_text_scroll_animation()
            while self.layout_view:is_text_scroll_scrolling() do
                coroutine.yield()
            end
            common.wait(30)
        end
        coroutine.yield()
    end
end

value.co_update = coroutine.create(
    function()
        value.update(value)
    end
)

return value;