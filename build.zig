const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // 1. Create the root module
    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // 2. Define the executable artifact
    const exe = b.addExecutable(.{
        .name = "zigtils",
        .root_module = exe_mod,
    });

    b.installArtifact(exe);

    // 3. Add the check step for LSP / ZLS
    const check_step = b.step("check", "Check the project for compilation errors");

    // Create a parallel check artifact using the same module
    const check_exe = b.addExecutable(.{
        .name = "zigtils",
        .root_module = exe_mod,
    });
    check_step.dependOn(&check_exe.step);

    // 4. Configure run command and pass-through arguments
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    run_cmd.addPassthruArgs();

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // 5. Unit tests configuration
    const exe_unit_tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
