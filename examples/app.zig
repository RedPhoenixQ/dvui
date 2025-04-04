const std = @import("std");
const dvui = @import("dvui");

pub fn init() !dvui.Runner.InitOptions {
    std.debug.print("init\n", .{});
    return .{
        .size = .{ .w = 800.0, .h = 600.0 },
        .title = "MyApp",
    };
}

pub fn frame() !void {
    if (try dvui.button(@src(), "Examples", .{}, .{})) {
        dvui.Examples.show_demo_window = !dvui.Examples.show_demo_window;
    }
    try dvui.Examples.demo();
}

pub fn deinit() !void {
    std.debug.print("deinit\n", .{});
}
