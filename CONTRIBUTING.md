# Contributing to Era

First of all, thank you for taking the time to visit the project.

Era started as a personal learning project while I was exploring Flutter desktop development and local AI. Over time, it has grown into something much bigger, and I'm continuing to improve it one step at a time.

Whether you've found a bug, have an idea for a feature, want to improve the documentation, or simply want to learn by contributing, you're welcome here.

---

# Before You Contribute

Please keep a few things in mind.

- The project is still evolving.
- Some parts of the architecture are intentionally simple and will be improved over time.
- I value clean, understandable code over clever code.
- Discussions and suggestions are always appreciated.

---

# Getting Started

Clone the repository:

```bash
git clone https://github.com/<your-username>/era.git
```

Move into the project:

```bash
cd era
```

Install dependencies:

```bash
flutter pub get
```

Start Ollama:

```bash
ollama serve
```

Run the application:

```bash
flutter run -d windows
```

---

# Coding Style

A few guidelines I try to follow throughout the project:

- Keep code readable.
- Prefer simple solutions over complex ones.
- Follow the existing project structure.
- Write meaningful class and method names.
- Remove unused code before creating a pull request.
- Format code before committing.

Run:

```bash
dart format lib
```

and

```bash
flutter analyze
```

before opening a Pull Request.

---

# Reporting Bugs

If you find a bug, please include:

- What happened
- Steps to reproduce
- Expected behavior
- Screenshots (if applicable)
- Operating system
- Flutter version
- Ollama version
- Model being used

The more details you provide, the easier it will be to investigate.

---

# Suggesting Features

Feature ideas are always welcome.

When suggesting a feature, try to explain:

- The problem you're trying to solve.
- Your proposed solution.
- Why it would improve Era.

Even if an idea isn't implemented immediately, it may help shape future development.

---

# Pull Requests

Before submitting a Pull Request:

- Make sure the project builds successfully.
- Keep changes focused on a single topic whenever possible.
- Update documentation if necessary.
- Keep commit messages clear and descriptive.

Example:

```
Improve chat message layout

Fix markdown rendering

Refactor memory service

Add document import validation
```

---

# Project Philosophy

Era follows a few principles that guide development.

- Privacy first.
- Offline by default.
- Keep the architecture modular.
- Build a strong foundation before adding features.
- Learn continuously and improve incrementally.

---

# A Note

I'm still learning.

Many parts of this project were built while exploring Flutter, desktop development, software architecture, and local AI.

I also relied on excellent learning resources, official documentation, open-source projects, and tools like ChatGPT to better understand concepts and improve the implementation.

If you notice something that could be written better or designed differently, constructive feedback is always appreciated.

---

Thank you for helping make Era better.