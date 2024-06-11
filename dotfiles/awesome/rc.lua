-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local lain = require("lain")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification({
        urgency = "critical",
        title = "Oops, an error happened" ..
            (startup and " during startup!" or "!"),
        message = message
    })
end)
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "sky/theme.lua")
-- beautiful.init(string.format("%s/.config/awesome/themes/theme.lua", os.getenv("HOME")))
local chosen_theme = "catppuccin"
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua",
                                 os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    {
        "hotkeys",
        function() hotkeys_popup.show_help(nil, awful.screen.focused()) end
    }, {"manual", terminal .. " -e man awesome"},
    {"edit config", editor_cmd .. " " .. awesome.conffile},
    {"restart", awesome.restart}, {"quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({
    items = {
        {"awesome", myawesomemenu, beautiful.awesome_icon},
        {"open terminal", terminal}
    }
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
-- lain layout
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile, -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        awful.layout.suit.floating, -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
        lain.layout.termfair.center, -- lain.layout.centerwork,,
        lain.layout.centerwork
    })
end)

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol = 1

-- }}}

-- {{{ Wibar

-- Keyboard map indicator and switchers
mykeyboardlayout = awful.widget.keyboardlayout()

-- My custom widget
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local calendar_widget = require("calendar")
local cw = calendar_widget({
    theme = "cappuccin_macchito",
    placement = "top_right",
    start_sunday = true,
    radius = 8,
    previous_month_button = 4,
    next_month_button = 5
})
-- local brightness_widget = require("brightness")
-- local separators = lain.util.separators
-- local arrow = separators.arrow_left
local markup = lain.util.markup
-- local dpi = require("beautiful.xresources").apply_dpi
-- local cpuicon = wibox.widget.imagebox(os.getenv("HOME") ..
--                                           "/.config/awesome/icons/cpu.png")
-- local cpu = lain.widget.cpu({
--     settings = function()
--         widget:set_markup(markup.fontfg("sans 8", "#e33a6e",
--                                         cpu_now.usage .. "% "))
--     end
-- })
-- local memicon = wibox.widget.imagebox(os.getenv("HOME") ..
--                                           "/.config/awesome/icons/mem.png")
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg("sans 8", "#ffffff",
                                        mem_now.used .. "M "))
    end
})

-- Clock widget
mytextclock = wibox.widget.textclock("%a %b %d %H:%M:%S", 1)
mytextclock:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then cw.toggle() end
end)
container_clock_widget = {
    {
        {
            {widget = mytextclock},
            left = 6,
            right = 6,
            top = 0,
            bottom = 0,
            widget = wibox.container.margin
        },
        shape = gears.shape.rounded_bar,
        fg = "#cba6f7",
        bg = widget_bg,
        widget = wibox.container.background
    },
    spacing = 5,
    layout = wibox.layout.fixed.horizontal
}

-- vicious widget
local vicious = require("vicious")
local netwidget = wibox.widget.textbox()
vicious.register(netwidget, vicious.widgets.net,
                 "↓${wlp12s0 down_kb}kb ↑${wlp12s0 up_kb}kb", 3)
local memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "Mem: $1% ($2MB/$3MB)", 13)
local uptimewidget = wibox.widget.textbox()
vicious.register(uptimewidget, vicious.widgets.uptime, "$1d $2h $3m", 60)

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s,
              awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox({
        screen = s,
        buttons = {
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(-1) end),
            awful.button({}, 5, function() awful.layout.inc(1) end)
        }
    })

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({modkey}, 1, function(t)
                if client.focus then client.focus:move_to_tag(t) end
            end), awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({modkey}, 3, function(t)
                if client.focus then client.focus:toggle_tag(t) end
            end),
            awful.button({}, 4, function(t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function(t)
                awful.tag.viewnext(t.screen)
            end)
        }
    })

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({}, 1, function(c)
                c:activate(
                    {context = "tasklist", action = "toggle_minimization"})
            end), awful.button({}, 3, function()
                awful.menu.client_list({theme = {width = 250}})
            end),
            awful.button({}, 4, function()
                awful.client.focus.byidx(-1)
            end),
            awful.button({}, 5, function()
                awful.client.focus.byidx(1)
            end)
        }
    })

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        widget = {
            layout = wibox.layout.align.horizontal,
            {layout = wibox.layout.fixed.horizontal, s.mytaglist, s.mypromptbox},
            s.mytasklist,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 10,
                wibox.widget.systray(),
                volume_widget(),
                cpu_widget({
                    width = 30,
                    step_width = 2,
                    step_spacing = 0,
                    color = "#434c5e"
                }),
                memory.widget,
                netwidget,
                container_clock_widget,
                s.mylayoutbox
            }
        }
    })
end)

-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewprev),
    awful.button({}, 5, awful.tag.viewnext)
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "s", hotkeys_popup.show_help,
              {description = "show help", group = "awesome"}),
    awful.key({modkey}, "w", function() mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),
    awful.key({modkey, "Control"}, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}), -- awful.key({ modkey, "Shift" }, "q", awesome.quit,
    --     { description = "quit awesome", group = "awesome" }),
    awful.key({modkey}, "x", function()
        awful.prompt.run({
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
        })
    end, {description = "lua execute prompt", group = "awesome"}),
    awful.key({modkey}, "Return", function() awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({modkey}, "r",
              function() awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    awful.key({modkey}, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "Left", awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({modkey}, "Right", awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({modkey}, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"})
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({modkey}, "j", function() awful.client.focus.byidx(1) end,
              {description = "focus next by index", group = "client"}),
    awful.key({modkey}, "k", function() awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}),
    awful.key({modkey}, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end, {description = "go back", group = "client"}), -- HACK: focus_relative is swapped
    -- make the focus in order of left to right instead of right to left
    --  https://github.com/awesomeWM/awesome/issues/1122
    awful.key({modkey, "Control"}, "j",
              function() awful.screen.focus_relative(-1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({modkey, "Control"}, "k",
              function() awful.screen.focus_relative(1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({modkey, "Control"}, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then c:activate({raise = true, context = "key.unminimize"}) end
    end, {description = "restore minimized", group = "client"})
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({modkey, "Shift"}, "j", function() awful.client.swap.byidx(1) end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({modkey, "Shift"}, "k",
              function() awful.client.swap.byidx(-1) end, {
        description = "swap with previous client by index",
        group = "client"
    }), awful.key({modkey}, "u", awful.client.urgent.jumpto,
                  {description = "jump to urgent client", group = "client"}),
    awful.key({modkey}, "l", function() awful.tag.incmwfact(0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({modkey}, "h", function() awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({modkey, "Shift"}, "h",
              function() awful.tag.incnmaster(1, nil, true) end, {
        description = "increase the number of master clients",
        group = "layout"
    }), awful.key({modkey, "Shift"}, "l",
                  function() awful.tag.incnmaster(-1, nil, true) end, {
        description = "decrease the number of master clients",
        group = "layout"
    }), awful.key({modkey, "Control"}, "h",
                  function() awful.tag.incncol(1, nil, true) end, {
        description = "increase the number of columns",
        group = "layout"
    }), awful.key({modkey, "Control"}, "l",
                  function() awful.tag.incncol(-1, nil, true) end, {
        description = "decrease the number of columns",
        group = "layout"
    }), awful.key({modkey}, "space", function() awful.layout.inc(1) end,
                  {description = "select next", group = "layout"}),
    awful.key({modkey, "Shift"}, "space", function() awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"})
})

awful.keyboard.append_global_keybindings({
    awful.key({
        modifiers = {modkey},
        keygroup = "numrow",
        description = "only view tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then tag:view_only() end
        end
    }), awful.key({
        modifiers = {modkey, "Control"},
        keygroup = "numrow",
        description = "toggle tag",
        group = "tag",
        on_press = function(index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then awful.tag.viewtoggle(tag) end
        end
    }), awful.key({
        modifiers = {modkey, "Shift"},
        keygroup = "numrow",
        description = "move focused client to tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:move_to_tag(tag) end
            end
        end
    }), awful.key({
        modifiers = {modkey, "Control", "Shift"},
        keygroup = "numrow",
        description = "toggle focused client on tag",
        group = "tag",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then client.focus:toggle_tag(tag) end
            end
        end
    }), awful.key({
        modifiers = {modkey},
        keygroup = "numpad",
        description = "select layout directly",
        group = "layout",
        on_press = function(index)
            local t = awful.screen.focused().selected_tag
            if t then t.layout = t.layouts[index] or t.layout end
        end
    })
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({}, 1,
                     function(c) c:activate({context = "mouse_click"}) end),
        awful.button({modkey}, 1, function(c)
            c:activate({context = "mouse_click", action = "mouse_move"})
        end), awful.button({modkey}, 3, function(c)
            c:activate({context = "mouse_click", action = "mouse_resize"})
        end)
    })
end)

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({modkey}, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, {description = "toggle fullscreen", group = "client"}),
        awful.key({modkey, "Shift"}, "c", function(c) c:kill() end,
                  {description = "close", group = "client"}),
        awful.key({modkey, "Control"}, "space", awful.client.floating.toggle,
                  {description = "toggle floating", group = "client"}),
        awful.key({modkey, "Control"}, "Return",
                  function(c) c:swap(awful.client.getmaster()) end,
                  {description = "move to master", group = "client"}),
        awful.key({modkey}, "o", function(c) c:move_to_screen() end,
                  {description = "move to screen", group = "client"}),
        awful.key({modkey}, "t", function(c) c.ontop = not c.ontop end,
                  {description = "toggle keep on top", group = "client"}),
        awful.key({modkey}, "n", function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, {description = "minimize", group = "client"}),
        awful.key({modkey}, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, {description = "(un)maximize", group = "client"}),
        awful.key({modkey, "Control"}, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, {description = "(un)maximize vertically", group = "client"}),
        awful.key({modkey, "Shift"}, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, {description = "(un)maximize horizontally", group = "client"})
    })
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule({
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap +
                awful.placement.no_offscreen
        }
    })

    -- Floating clients.
    ruled.client.append_rule({
        id = "floating",
        rule_any = {
            instance = {"copyq", "pinentry"},
            class = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester" -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    })

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule({
        id = "titlebars",
        rule_any = {type = {"normal", "dialog"}},
        properties = {titlebars_enabled = false}
    })
end)
-- }}}

-- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({}, 1, function()
            c:activate({context = "titlebar", action = "mouse_move"})
        end), awful.button({}, 3, function()
            c:activate({context = "titlebar", action = "mouse_resize"})
        end)
    }

    awful.titlebar(c).widget = {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                halign = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)
-- }}}

-- {{{ Notifications

ruled.notification.connect_signal("request::rules", function()
    -- All notifications will match this rule.
    ruled.notification.append_rule({
        rule = {},
        properties = {screen = awful.screen.preferred, implicit_timeout = 5}
    })
end)

naughty.connect_signal("request::display",
                       function(n) naughty.layout.box({notification = n}) end)

-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate({context = "mouse_enter", raise = false})
end)

-- ============
-- Customization
-- ============
-- xmodmap:  up to 4 keys per modifier, (keycodes in parentheses):
-- shift       Shift_L (0x32),  Shift_R (0x3e)
-- lock        Caps_Lock (0x42)
-- control     Control_L (0x25),  Control_R (0x69)
-- mod1        Alt_L (0x40),  Alt_R (0x6c),  Alt_L (0xcc),  Meta_L (0xcd)
-- mod2        Num_Lock (0x4d)
-- mod3        ISO_Level5_Shift (0xcb)
-- mod4        Super_L (0x85),  Super_R (0x86),  Super_L (0xce),  Hyper_L (0xcf)
-- mod5        ISO_Level3_Shift (0x5c)
-- Use xev to get the keycodes
awful.keyboard.append_global_keybindings({
    awful.key({"Mod1"}, "space", function()
        awful.util.spawn(
            "rofi -show combi -combi-modes 'window,run,ssh' -modes combi -dpi 150 -show-icons")
    end), awful.key({modkey, "Shift"}, "q",
                    function() awful.util.spawn("archlinux-logout") end,
                    {description = "archlinux-logout", group = "awesome"}),
    awful.key({"Mod1", "Control"}, "l",
              function() awful.util.spawn("betterlockscreen -l") end,
              {description = "lock screen", group = "hotkeys"}),
    awful.key({modkey}, "Next", function()
        awful.spawn.with_shell("$HOME/.config/hypr/scripts/brightness --dec")
    end), awful.key({modkey}, "Prior", function()
        awful.spawn.with_shell("$HOME/.config/hypr/scripts/brightness --inc")
    end), awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn.with_shell("$HOME/.config/hypr/scripts/brightness --dec")
    end), awful.key({}, "XF86MonBrightnessUp", function()
        awful.spawn.with_shell("$HOME/.config/hypr/scripts/brightness --inc")
    end), awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn.with_shell("$HOME/.config/hypr/scripts/volume --dec")
    end), awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn.with_shell("$HOME/.config/hypr/scripts/volume --inc")
    end), awful.key({}, "XF86AudioMute", function()
        awful.spawn.with_shell("$HOME/.config/hypr/scripts/volume --toggle")
    end), awful.key({}, "XF86AudioPlay", function()
        awful.util.spawn("playerctl play-pause", false)
    end), awful.key({}, "XF86AudioNext",
                    function() awful.util.spawn("playerctl next", false) end),
    awful.key({}, "XF86AudioPrev",
              function() awful.util.spawn("playerctl previous", false) end),
    awful.key({}, "Print", function() awful.spawn("flameshot gui") end),
    awful.key({modkey, "Shift"}, "s",
              function() awful.spawn("flameshot gui") end)
})

-- Appearance stuff
beautiful.useless_gap = 10
beautiful.notification_opacity = "100"
beautiful.notification_icon_size = 80
beautiful.notification_bg = "(0,0,0)"
beautiful.notification_fg = "#d4be98"
-- beautiful.font = "Roboto Mono Nerd Font 10"
-- Autostart
-- will rerun each time restart AwesomeWM
-- run once put on ~/.xprofile
awful.spawn.with_shell("xfce4-power-manager")

-- https://www.reddit.com/r/awesomewm/comments/14ld9cl/shifting_to_wm/
