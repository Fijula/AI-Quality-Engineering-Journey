# Week 1 Interview Sheet

## AI Fundamentals

### Q1. What is Artificial Intelligence?

Artificial Intelligence (AI) is the broad field of creating systems that can perform tasks that typically require human intelligence, such as reasoning, decision-making, and pattern recognition.

---

### Q2. Does AI always require Machine Learning?

No.

Rule-based systems like expert systems, thermostats, and traditional chess engines are AI systems but do not learn from data.

---

### Q3. What is Machine Learning?

Machine Learning is a subset of AI where systems learn patterns from data instead of relying on manually written rules.

---

### Q4. What is the difference between AI and ML?

AI is the broader goal of creating intelligent systems.

ML is one approach used to achieve AI by learning from data.

---

### Q5. What is Deep Learning?

Deep Learning is a subset of Machine Learning that uses neural networks with multiple layers to learn complex patterns.

---

### Q6. What is the difference between ML and Deep Learning?

Machine Learning often requires manual feature engineering.

Deep Learning automatically learns features from raw data.

---

### Q7. What is Generative AI?

Generative AI is a subset of Deep Learning that creates new content such as text, images, audio, video, and code.

---

### Q8. Give examples of Generative AI.

* ChatGPT
* Claude
* Gemini
* Midjourney
* Stable Diffusion
* GitHub Copilot

---

### Q9. What is the hierarchy?

AI
→ Machine Learning
→ Deep Learning
→ Generative AI

---

## Coding Questions

### Q10. What is Valid Anagram?

Two strings are anagrams if they contain the same characters with the same frequency.

Example:

listen → silent

---

### Q11. Best approach for Valid Anagram?

HashMap / Dictionary

Count the frequency of each character and compare.

---

### Q12. Time Complexity of Valid Anagram?

O(n)

---

### Q13. Space Complexity of Valid Anagram?

O(n)

---

### Q14. What is the Valid Parentheses problem?

Determine whether brackets are properly opened and closed.

Example:

()[]{} → Valid

([)] → Invalid

---

### Q15. Best data structure for Valid Parentheses?

Stack

Because brackets must be closed in reverse order.

---

### Q16. Time Complexity of Valid Parentheses?

O(n)

---

### Q17. Space Complexity of Valid Parentheses?

O(n)

---

## SQL Questions

### Q18. What is a Database Schema?

A schema defines the structure of a database, including tables, columns, relationships, and constraints.

---

### Q19. Difference between Schema and Data?

Schema = Structure

Data = Actual records stored in tables

---

### Q20. What is a Primary Key?

A column that uniquely identifies each row in a table.

Example:

employee_id

---

### Q21. What is a Foreign Key?

A column that references a primary key in another table.

Used to maintain relationships between tables.

---

### Q22. Why are constraints important?

They maintain data integrity and prevent invalid data from being stored.

Examples:

* PRIMARY KEY
* FOREIGN KEY
* UNIQUE
* NOT NULL

---

### Q9b. Why does testing change as we move from rule-based AI to Generative AI?

Because the systems get less predictable as you go down the hierarchy:

* **Rule-based AI** → same input always gives the same output, so you test for exact expected results.
* **ML / Deep Learning** → outputs are probabilistic, so you evaluate with metrics like accuracy, precision, and recall.
* **Generative AI** → many different answers can be valid, so testing shifts to relevance, factuality, safety, and hallucinations.

> Deeper dive (metrics, hallucinations, evaluation) comes in **Week 2**.

---

### Q9c. How is testing an AI/ML system different from testing traditional software?

Traditional software is deterministic — for a given input there is one correct, fixed output, so you assert exact expected results.

AI/ML systems are data-driven and probabilistic — the output can change with the model or data, and for GenAI many outputs may be acceptable. So you test behaviour and quality (metrics, ranges, properties) rather than a single hard-coded expected value.

---

### Q9d. What is the "oracle problem" in testing AI?

A test oracle is the mechanism that tells you whether an output is correct.

For GenAI there is often no single correct answer, so a simple exact-match oracle does not work. Instead we use partial oracles — checking relevance, factuality, safety, or properties of the output (e.g. "the summary must not add facts not in the source").

> Techniques to handle this (metamorphic testing, LLM-as-judge, metrics) are covered in **Week 2**.

---

## DevOps / Environment Questions

### Q23. Why do we use virtual environments in Python?

To isolate each project's dependencies.

Without isolation, two projects needing different versions of the same package (e.g. `pandas 1.5` vs `2.2`) would conflict. A virtual environment gives each project its own packages so they never clash.

---

### Q24. What is the difference between venv and conda?

`venv` is built into Python and uses `pip`; it only manages Python packages.

`conda` is a separate tool that also manages non-Python dependencies (C libraries, CUDA) and the Python version itself. It is popular in data science / ML.

---

### Q25. What is the difference between Anaconda and Miniconda?

Anaconda is a large distribution with conda plus 250+ preinstalled data-science packages.

Miniconda is just conda and Python — you install only what you need.

---

### Q26. How do you make a Python environment reproducible?

Record the dependencies in a file and commit it (not the environment folder):

* `pip freeze > requirements.txt` → `pip install -r requirements.txt`
* `conda env export > environment.yml` → `conda env create -f environment.yml`

---

## Week 1 Key Takeaways

* AI is the broadest concept.
* ML learns from data.
* DL uses neural networks.
* GenAI creates new content.
* HashMap solves Valid Anagram efficiently.
* Stack is ideal for Valid Parentheses.
* Schemas define database structure.
* Primary and Foreign Keys maintain relationships.
* Virtual environments isolate project dependencies.
* Commit the dependency recipe (`requirements.txt` / `environment.yml`), never the environment folder.
