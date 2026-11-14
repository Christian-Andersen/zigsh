const std = @import("std");

pub fn mkdir(args: []const [:0]const u8, io: std.Io) !void {
    for (args) |arg| {
        try std.Io.Dir.cwd().createDirPath(io, arg);
    }
}
