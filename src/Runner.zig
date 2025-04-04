//! Used for applications were dvui provides the main function of the application.
//! This makes using multiple backends easier as the application code does not
//! have to change between backends.
//!
//! TODO: Explain what functions the applications should provide

const dvui = @import("dvui.zig");

pub const InitOptions = struct {
    /// The initial size of the application window
    size: dvui.Size,
    /// Set the minimum size of the window
    min_size: ?dvui.Size = null,
    /// Set the maximum size of the window
    max_size: ?dvui.Size = null,
    vsync: bool = true,
    /// The application title to display
    title: [:0]const u8,
    /// content of a PNG image (or any other format stb_image can load)
    /// tip: use @embedFile
    icon: ?[:0]const u8 = null,
};
