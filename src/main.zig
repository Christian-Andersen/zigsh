const std = @import("std");

const cat = @import("cat.zig").cat;
const mkdir = @import("mkdir.zig").mkdir;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const allocator = init.arena.allocator();
    const args = (try init.minimal.args.toSlice(allocator))[1..];
    if (args.len == 0) {
        @panic("Plase pass arguments!");
    }
    if (std.mem.eql(u8, args[0], "cat")) {
        try cat(args[1..], io);
    } else if (std.mem.eql(u8, args[0], "mkdir")) {
        try mkdir(args[1..], io);
    } else {
        @panic("Not implemented");
    }
}
