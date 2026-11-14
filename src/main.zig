const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const allocator = init.arena.allocator();
    const full_args = try init.minimal.args.toSlice(allocator);
    const args = full_args[1..full_args.len];
    if (args.len == 0) {
        @panic("Plase pass arguments!");
    }
    for (args, 0..) |arg, i| {
        std.debug.print("{d}: {s}\n", .{ i, arg });
    }
}
