#!/usr/bin/swift

/// Given an array of integers, return indices of the two numbers such that they add up to a specific target.
/// You may assume that each input would have exactly one solution, and you may not use the same element twice.
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        if nums.isEmpty || nums.count == 1 { return [] }

        /// hash(dictionary) of [Number: Index]
        var hash: [Int: Int] = [:]

        for i in 0..<nums.count {
            let diff = target - nums[i]
            if let sumLessTargetIndex = hash[diff] {
                return [sumLessTargetIndex, i]
            } else {
                hash[nums[i]] = i
            }
        }
        return []
    }


print("([2, 7, 11, 15], 9): ", twoSum([2, 7, 11, 15], 9))
print("([3, 5, 2, -4, 8, 11], 7): ", twoSum([3, 5, 2, -4, 8, 11], 4))