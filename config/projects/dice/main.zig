const std = @import("std");

const err = error{ wrongSizeArrays, currentBiggerThanTarget, currentHasZero };

fn next(comptime size: i32, current: [size]i32, target: [size]i32) ![size]i32 {
    if (current.len != target.len) {
        return err.wrongSizeArrays;
    }
    for (current, target) |x, y| {
        if (x > y) {
            return err.currentBiggerThanTarget;
        }
        if (x == 0) {}
    }
    var result = current;
    for (current, 0..) |num, index| {
        if (num == target[index]) {
            if (index + 1 == current.len) {
                return target;
            }
            result[index] = 1;
            continue;
        } else if (num < target[index]) {
            result[index] = current[index] + 1;
            break;
        }
    }
    return result;
}

fn rollSum(comptime size: i32, arr: [size]i32) i32 {
    var res: i32 = 0;
    for (arr) |e| {
        res += e;
    }
    return res;
}

fn rollSums(comptime size: i32, bonus: i32) ![std.math.pow(u32, 6, size)]i32 {
    var current = std.mem.zeroes([size]i32);
    var target = std.mem.zeroes([size]i32);
    var result = std.mem.zeroes([std.math.pow(u32, 6, size)]i32);
    for (current, 0..) |_, i| {
        current[i] = 1;
    }
    for (target, 0..) |_, i| {
        target[i] = 6;
    }
    for (0..std.math.pow(u32, 6, size)) |e| {
        result[e] = rollSum(size, current) + bonus;
        current = try next(size, current, target);
    }
    return result;
}

fn compareArrays(comptime size1: i32, arr1: [size1]i32, comptime size2: i32, arr2: [size2]i32) [3]i32 {
    var wins: i32 = 0;
    var draws: i32 = 0;
    var loses: i32 = 0;
    for (arr1) |x| {
        for (arr2) |y| {
            if (x > y) {
                wins += 1;
            } else if (x == y) {
                draws += 1;
            } else if (x < y) {
                loses += 1;
            }
        }
    }
    return [3]i32{ wins, draws, loses };
}

fn printArray(comptime size: i32, x: [size]i32) void {
    for (x) |val| {
        std.debug.print("{d}\n", .{val});
    }
}

pub fn main() !void {
    const sz1 = 3;
    const sz2 = 4;
    const sums1 = try rollSums(sz1, 4);
    const sums2 = try rollSums(sz2, 0);
    const results = compareArrays(std.math.pow(u32, 6, sz1), sums1, std.math.pow(u32, 6, sz2), sums2);

    printArray(3, results);
}
