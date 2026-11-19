const std = @import("std");

pub fn mkdir(args: *std.mem.TokenIterator(u8, .scalar), io: std.Io) !void {
    while (args.next()) |arg| {
        try std.Io.Dir.cwd().createDirPath(io, arg);
    }
}
