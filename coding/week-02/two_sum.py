"""
Week 02 | Problem 1: Two Sum
Pattern: Hash map (complement lookup)

PROBLEM
-------
Given an array of integers nums and an integer target, return the indices
of the two numbers that add up to target. Exactly one solution exists and
you may not use the same element twice.
    two_sum([2, 7, 11, 15], 9) -> [0, 1]   (2 + 7)
    two_sum([3, 2, 4], 6)      -> [1, 2]   (2 + 4)
    two_sum([3, 3], 6)         -> [0, 1]

KEY IDEA
--------
For each number x we need (target - x), its "complement". Instead of
scanning the rest of the array for it (O(n^2)), keep a hash map of
{value -> index} of everything seen so far. At each element, check if its
complement is already in the map in O(1); if so, we're done.

COMPLEXITY
----------
Time : O(n)   (single pass, O(1) map lookups)
Space: O(n)   (map can hold up to n entries)
"""


def two_sum(nums: list[int], target: int) -> list[int]:
    seen = {}                          # value -> index
    for i, x in enumerate(nums):
        complement = target - x
        if complement in seen:
            return [seen[complement], i]
        seen[x] = i
    return []                          # no pair (won't happen per problem)


def two_sum_brute(nums: list[int], target: int) -> list[int]:
    """O(n^2) baseline — check every pair. Shown for contrast."""
    for i in range(len(nums)):
        for j in range(i + 1, len(nums)):
            if nums[i] + nums[j] == target:
                return [i, j]
    return []


if __name__ == "__main__":
    for fn in (two_sum, two_sum_brute):
        assert fn([2, 7, 11, 15], 9) == [0, 1]
        assert fn([3, 2, 4], 6) == [1, 2]
        assert fn([3, 3], 6) == [0, 1]
    print("two_sum: all tests passed ✅")
