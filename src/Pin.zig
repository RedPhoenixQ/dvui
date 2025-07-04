//! This type can be added as a field in other structs to perform
//! runtime checks that the struct pointer hasn't moved. This is
//! important for structs that might have pointer to internal
//! fields which should not be moved.
//!
//! The `Pin.check` function should be called at the top of each
//! method of the struct, or it can be called explicitly before
//! the struct is used.

const std = @import("std");
const assert = std.debug.assert;

const Pin = @This();

const enabled = std.debug.runtime_safety;

pinned_address: if (enabled) ?*Pin else void = if (enabled) null else {},

/// Pins `self` to the current address of `self`
///
/// Asserts that `self` is NOT currently pinned
pub fn pin(self: *Pin) void {
    if (!enabled) return;
    std.debug.assert(self.pinned_address == null);
    self.pinned_address = self;
}

/// Asserts that `self` is currently pinned
pub fn unpin(self: *Pin) void {
    if (!enabled) return;
    std.debug.assert(self.pinned_address == self);
    self.pinned_address = null;
}

/// Returns where `self` is currently pinned
pub fn pinned(self: *const Pin) bool {
    if (!enabled) return;
    return self.pinned_address != null;
}

/// If we are pinned, asserts that `self` points to the pinned address.
///
/// This does nothing if `self` is unpinned
pub fn check(self: *const Pin) void {
    if (!enabled) return;
    if (self.pinned_address) |address| {
        std.debug.assert(address == self); // Value was copied/moved since it was pinned
    }
}

test {
    @import("std").testing.refAllDecls(Pin);
}
