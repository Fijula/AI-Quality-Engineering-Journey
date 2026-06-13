# DevOps — Week 1: Python Environments & Project Setup

Before writing any code, you need a clean, reproducible place to run it. This week covers
**how Python finds packages, why we isolate environments, and the tools** (venv, pip, conda,
Makefiles) that make a project easy to set up on any machine.

---

## 1. Why environments matter

Imagine two projects on the same laptop:

- Project A needs `pandas 1.5`
- Project B needs `pandas 2.2`

If you install packages globally (system-wide), they fight over the **same** `pandas`.
Installing one breaks the other. This is **dependency hell**.

The fix: give each project its **own isolated environment** — a private folder with its own
Python and its own packages. Switching projects = switching environments. Nothing leaks.

> **Golden rule:** never `pip install` into your system Python. Always work inside an environment.

---

## 2. Installing Python

Check what you already have:

```bash
python3 --version
which python3
```

Ways to install:

| Method | When to use |
|--------|-------------|
| **python.org installer** | Simple, official, one version. |
| **Homebrew** (`brew install python`) | macOS users who already use Homebrew. |
| **pyenv** | You need to switch between many Python *versions* (3.10, 3.11, 3.12…). |
| **Miniconda/Anaconda** | You want conda to manage Python itself (see §5). |

---

## 3. `venv` — the built-in way (recommended to start)

`venv` ships with Python. No extra install. It creates a folder holding an isolated Python.

```bash
# create an environment named ".venv" in your project
python3 -m venv .venv

# activate it (macOS / Linux)
source .venv/bin/activate

# you're now "inside" — your prompt shows (.venv)
# install packages here; they stay local to this project
pip install pandas numpy

# leave the environment
deactivate
```

After activation, `python` and `pip` point **inside** `.venv`, not the system.

> Add `.venv/` to `.gitignore` — you never commit the environment itself, only the
> *recipe* to rebuild it (see §4).

---

## 4. `pip` and `requirements.txt`

`pip` is Python's package installer. To make your environment reproducible, you record exactly
what you installed:

```bash
# save the current packages + versions to a file
pip freeze > requirements.txt

# on another machine: recreate the exact environment
pip install -r requirements.txt
```

A `requirements.txt` looks like:

```
pandas==2.2.0
numpy==1.26.4
```

This is the file you **do** commit to git — it's how teammates reproduce your setup.

---

## 5. What is conda?

**conda** is an alternative package + environment manager. The big differences from `pip`/`venv`:

- It manages **non-Python** things too (C libraries, CUDA, even Python itself).
- It's popular in **data science / ML** where packages have heavy native dependencies.

Three names people confuse:

| Name | What it is |
|------|------------|
| **Anaconda** | A big distribution: conda + 250+ preinstalled data-science packages (~3 GB). |
| **Miniconda** | Just conda + Python, nothing else. Lightweight — install only what you need. |
| **conda** | The actual command-line tool that both ship. |

> For most people: install **Miniconda**, then add packages yourself.

### conda basics

```bash
# create an environment with a specific Python version
conda create -n myenv python=3.11

# activate / deactivate
conda activate myenv
conda deactivate

# install packages
conda install pandas numpy

# list / remove environments
conda env list
conda remove -n myenv --all
```

### conda vs venv — which do I use?

| | venv + pip | conda |
|--|-----------|-------|
| Comes with Python | ✅ | ❌ (install Miniconda) |
| Manages Python version | ❌ | ✅ |
| Best for | general/web Python | data science, ML, native deps |
| Reproducibility file | `requirements.txt` | `environment.yml` |

**Pick one per project and stay consistent.** Mixing `pip` and `conda` in the same env can
cause conflicts — if you must, install conda packages first, then pip.

conda's reproducibility file:

```bash
conda env export > environment.yml      # save
conda env create -f environment.yml     # recreate
```

---

## 6. What is a Makefile?

A **Makefile** is a tiny file of named shortcuts for the commands you run all the time.
Instead of remembering long commands, you type `make <name>`.

Create a file literally named `Makefile`:

```makefile
# NOTE: Makefiles require TAB indentation, not spaces.

.PHONY: setup install test clean

setup:           ## create the virtual environment
	python3 -m venv .venv

install:         ## install dependencies into .venv
	./.venv/bin/pip install -r requirements.txt

test:            ## run the test suite
	./.venv/bin/python -m pytest

clean:           ## remove the environment and caches
	rm -rf .venv __pycache__
```

Now anyone can set up the project with two commands:

```bash
make setup
make install
```

Why it's useful:

- **One source of truth** for "how do I run this project?"
- New teammates don't need a wiki — they read the Makefile.
- Works the same on every machine.

> **Gotcha:** the indentation under each target **must be a real TAB**, not spaces.
> This is the #1 Makefile error (`Makefile:5: *** missing separator`).

---

## 7. Recommended project workflow

```bash
# 1. create + activate environment
python3 -m venv .venv
source .venv/bin/activate

# 2. install what you need
pip install pandas pytest

# 3. record it
pip freeze > requirements.txt

# 4. commit requirements.txt (NOT .venv) to git
```

`.gitignore` should contain:

```
.venv/
__pycache__/
*.pyc
```

---

## Week 1 Key Takeaways

* **Never** install packages into system Python — always use an environment.
* **venv + pip** is built-in and great for general projects.
* **conda** (via Miniconda) shines for data science / ML and manages Python itself.
* Commit the **recipe** (`requirements.txt` / `environment.yml`), never the environment folder.
* A **Makefile** turns long setup commands into simple `make` shortcuts — mind the TABs.
