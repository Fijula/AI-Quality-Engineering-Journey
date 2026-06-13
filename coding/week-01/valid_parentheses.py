"""
Week 01 | Problem 2: Valid Parentheses
Pattern: Stack (matching pairs / LIFO)

PROBLEM
-------
Given a string s of just the characters '()[]{}', return True if every
bracket is closed by the correct type in the correct order.
    "()[]{}" -> True
    "(]"     -> False
    "([)]"   -> False
    "{[]}"   -> True

KEY IDEA
--------
A stack models "most recently opened must close first". Push openers;
on a closer, the top of the stack MUST be its matching opener. At the
end the stack must be empty (leftover openers => unclosed).

COMPLEXITY
----------
Time : O(n)   (one pass, push/pop are O(1))
Space: O(n)   (worst case all openers on the stack)
"""


def is_valid(s: str) -> bool:
    pairs = {')': '(', ']': '[', '}': '{'}   # closer -> matching opener
    stack = []
    for ch in s:
        if ch in pairs.values():             # an opener
            stack.append(ch)
        elif ch in pairs:                    # a closer
            if not stack or stack.pop() != pairs[ch]:
                return False
    return not stack


if __name__ == "__main__":
    assert is_valid("()[]{}") is True
    assert is_valid("(]") is False
    assert is_valid("([)]") is False
    assert is_valid("{[]}") is True
    assert is_valid("(") is False
    assert is_valid("") is True
    print("valid_parentheses: all tests passed ✅")
