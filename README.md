# AI Journey Weekly

A weekly learning log on the journey from **AI fundamentals to interviews **, paired with the
**coding** and **SQL** practice that goes alongside it.

Each week ships three things:

1. **Concept notes** — the week's theory (AI/ML/DL/GenAI, evaluation, etc.).
2. **Coding problems** — clean, commented Python solutions with complexity notes.
3. **SQL practice** — queries built on a single recurring toy schema, so each week builds on the last.

Plus an **interview sheet** per week — quick Q&A to revise the concepts before interviews.

---

## Repository structure

```
genai-weekly/
├── coding/
│   ├── week-01/
│   │   ├── valid_anagram.py        # Frequency counting (hash map)  — O(n)
│   │   └── valid_parentheses.py    # Stack / matching pairs (LIFO)  — O(n)
│   └── week-02/
│       ├── two_sum.py              # Hash map / complement lookup   — O(n)
│       └── longest_palindromic_substring.py  # Expand around center — O(n²)
├── sql/
│   ├── schema.sql                  # Recurring toy schema (PostgreSQL)
│   ├── week-01.sql                 # WHERE → GROUP BY / HAVING
│   └── week-02.sql                 # JOINs: INNER, LEFT, RIGHT, FULL, SELF, CROSS
├── devops/
│   └── week-01.md                  # Python environments: venv, pip, conda, Makefile
├── interview/
│   └── week-01.md                  # Week 1 interview Q&A sheet
├── articles/
│   └── week-01.md                  # Links to the week's published Medium blogs
└── README.md
```

> **Note:** Markdown drafts (roadmap, Medium blogs, LinkedIn posts) are kept **local only** via
> `.gitignore`. Only the README and the curated interview sheets are published.

---

## Weekly index

| Week | Concept | Coding | SQL | DevOps |
|------|---------|--------|-----|--------|
| 01 | AI vs ML vs Deep Learning vs Generative AI | Valid Anagram, Valid Parentheses | `WHERE`, `GROUP BY`, `HAVING` | Python environments: venv, pip, conda, Makefile |
| 02 | _(testing AI: metrics, hallucinations — in progress)_ | Two Sum, Longest Palindromic Substring | JOINs (INNER/LEFT/RIGHT/FULL/SELF/CROSS) | — |

---

## How to use this repo

- **Read** the week's interview sheet in [`interview/`](interview/) for a fast concept refresh.
- **Run** the coding solutions directly (each file is self-contained with examples):
  ```bash
  python coding/week-01/valid_anagram.py
  ```
- **Practice SQL** by loading [`sql/schema.sql`](sql/schema.sql) first, then running the week's queries.

---

## Concept recap — Week 1

> AI is the **goal**. Machine Learning **learns from data**. Deep Learning learns complex patterns
> using **neural networks**. Generative AI **creates new content**.

```
AI
└── Machine Learning
    └── Deep Learning
        └── Generative AI
```
