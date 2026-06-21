"""
Week 02 | Problem 2: Longest Palindromic Substring
Pattern: Expand around center (two pointers)

PROBLEM
-------
Given a string s, return the longest contiguous substring of s that reads
the same forwards and backwards.
    longest_palindrome("babad") -> "bab"   ("aba" is also valid)
    longest_palindrome("cbbd")  -> "bb"
    longest_palindrome("a")     -> "a"

KEY IDEA
--------
Every palindrome has a center. There are 2n - 1 possible centers:
  - n single characters  (odd-length palindromes, e.g. "aba")
  - n - 1 gaps between chars (even-length palindromes, e.g. "bb")
For each center, push two pointers outward while the characters match.
Track the longest stretch found. Simpler than DP and O(1) extra space.

COMPLEXITY
----------
Time : O(n^2)   (n centers, each expands up to n)
Space: O(1)     (only indices; the slice at the end is the output)
"""


def longest_palindrome(s: str) -> str:
    if len(s) < 2:
        return s

    start, end = 0, 0                          # best window [start, end]

    def expand(left: int, right: int) -> tuple[int, int]:
        """Grow outward while it stays a palindrome; return final bounds."""
        while left >= 0 and right < len(s) and s[left] == s[right]:
            left -= 1
            right += 1
        return left + 1, right - 1             # step back to last valid pair

    for center in range(len(s)):
        l1, r1 = expand(center, center)        # odd length  (center on a char)
        if r1 - l1 > end - start:
            start, end = l1, r1
        l2, r2 = expand(center, center + 1)    # even length (center on a gap)
        if r2 - l2 > end - start:
            start, end = l2, r2

    return s[start:end + 1]


if __name__ == "__main__":
    assert longest_palindrome("babad") in ("bab", "aba")
    assert longest_palindrome("cbbd") == "bb"
    assert longest_palindrome("a") == "a"
    assert longest_palindrome("") == ""
    assert longest_palindrome("ac") in ("a", "c")
    assert longest_palindrome("forgeeksskeegfor") == "geeksskeeg"
    print("longest_palindromic_substring: all tests passed ✅")
