"""
Week 01 | Problem 1: Valid Anagram
Pattern: Frequency counting (hash map)

PROBLEM
-------
Given two strings s and t, return True if t is an anagram of s
(same characters, same counts), else False.
    is_anagram("anagram", "nagaram") -> True
    is_anagram("rat", "car")         -> False

KEY IDEA
--------
Anagram == identical character frequencies. Build a count map from one
string and decrement with the other; any missing char or leftover count
means it's not an anagram. (Sorting also works but is O(n log n).)

COMPLEXITY
----------
Time : O(n)              (single pass to count, single pass to compare)
Space: O(k) -> O(1)      (k = distinct chars; bounded for a fixed alphabet)
"""
from collections import Counter


def is_anagram(s: str, t: str) -> bool:
    if len(s) != len(t):
        return False
    return Counter(s) == Counter(t)


def is_anagram_manual(s: str, t: str) -> bool:
    """Same idea without the library, to show the mechanics."""
    if len(s) != len(t):
        return False
    counts = {}
    for ch in s:
        counts[ch] = counts.get(ch, 0) + 1
    for ch in t:
        if ch not in counts:
            return False
        counts[ch] -= 1
        if counts[ch] == 0:
            del counts[ch]
    return len(counts) == 0


if __name__ == "__main__":
    for fn in (is_anagram, is_anagram_manual):
        assert fn("anagram", "nagaram") is True
        assert fn("rat", "car") is False
        assert fn("", "") is True
        assert fn("a", "ab") is False
    print("valid_anagram: all tests passed ✅")
