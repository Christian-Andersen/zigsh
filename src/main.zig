const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    var stdout_buffer: [4096]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writer(io, &stdout_buffer);
    const stdout = &stdout_writer.interface;
    var stdin_buffer: [1024]u8 = undefined;
    var stdin_reader = std.Io.File.stdin().reader(io, &stdin_buffer);
    const stdin = &stdin_reader.interface;

    while (true) {
        try stdout.print("> ", .{});
        try stdout.flush();
        const line = (try stdin.takeDelimiter('\n')) orelse break;
        try stdout.print("{s}\n", .{line});
        try stdout.flush();
    }
}
