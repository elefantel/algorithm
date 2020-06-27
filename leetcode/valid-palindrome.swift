#!/usr/bin/swift

import Foundation
/**
 Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
 Note: For the purpose of this problem, we define empty string as valid palindrome.
 */

// String manipulation in Swift is unneccessarily hard. This may not be the most intuitive solution even in Swift
// Faster than 83.60% of Swift online submissions for Valid Palindrome on Leetcode
// Uses less memory than 92.03% of Swift online submissions for Valid Palindrome on Leetcode

func isPalindrome(_ s: String) -> Bool {
    if s.isEmpty { return true }
    let string = s.lowercased()
    // Swift does not support subscripts in Strings because of grapheme clusters
    var start = string.startIndex
    // string.endIndex is pointing in memory beyond last element
    var end = string.index(string.endIndex, offsetBy: -1)
    
    func isAlphaNumeric(_ c: Character) -> Bool {
        return c.isLetter || c.isNumber
    }

    while start < end {
        // keep incrementing left position until we have alphanumeric
        while !isAlphaNumeric(string[start]) {
            // out-of-bounds check
            if let newStart = string.index(start, offsetBy: 1, limitedBy: end) {
                start = newStart
            } else if start == string.index(string.endIndex, offsetBy: -1) || start == end {
                // got to end of string, therefore we have palindrome
                return true
            }
        }

        // keep incrementing right position until we have alphanumeric
        while !isAlphaNumeric(string[end]) {
            // out-of-bounds check
            if let newEnd = string.index(end, offsetBy: -1, limitedBy: start) {
                end = newEnd
            } else if end == string.startIndex || start == end {
                // got to start of string, therefore we have palindrome
                return true
            }
        }

        // if chars don't match, not palindrome
        if string[start] != string[end] { return false }
        // if chars match and pointers pointing to the same char, we have palindrome
        if string[start] == string[end] && start == end { return true }
        // otherwise shift the pointers in both directions
        start = string.index(start, offsetBy: 1)
        end = string.index(end, offsetBy: -1)
    }
    return true
}