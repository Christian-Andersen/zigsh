const std = @import("std");

fn catFile(file: std.Io.File, io: std.Io) !void {
    var reader_buffer: [1024]u8 = undefined;
    var reader = file.reader(io, &reader_buffer);
    while (try reader.interface.takeDelimiter('\n')) |line| {
        var writer_buffer: [1024]u8 = undefined;
        var writer = std.Io.File.stdout().writer(io, &writer_buffer);
        try writer.interface.print("{s}\n", .{line});
        try writer.interface.flush();
    }
}

pub fn cat(args: []const [:0]const u8, io: std.Io) !void {
    if (args.len == 0) {
        try catFile(std.Io.File.stdin(), io);
        return;
    }
    for (args) |arg| {
        const file = try std.Io.Dir.cwd().openFile(io, arg, .{ .mode = .read_only });
        try catFile(file, io);
    }
}

test "cat" {
    const io = std.testing.io;
    const args = [_][]const u8{"sample.txt"};
    cat(args, io);
}
