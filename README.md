# Era


## Welcome

> Privacy-first offline AI desktop assistant built with Flutter and Ollama.

Era is an open-source desktop application that explores what a modern offline AI assistant can become when privacy, local execution, and extensibility are treated as first-class principles.

Unlike cloud-based AI assistants, Era is designed to run entirely on your own machine using local language models through Ollama. Conversations remain on your device, documents are processed locally, and no API keys or internet connection are required for the core AI experience once a model is installed.

---

# Why I Started Era

I started building Era as a personal learning project while exploring Flutter desktop development and local AI.

Initially, the goal was simply to understand how desktop applications communicate with local language models. As the project grew, it gradually became an opportunity to learn software architecture, state management, clean project organization, and how modern AI applications are structured.

Today, Era is still an early-stage project, but it represents the foundation of a much larger vision.

Rather than creating another ChatGPT clone, my goal is to explore what a privacy-first, offline AI workspace could look like.

---

# Project Objectives

The long-term vision for Era is to become an offline AI workspace capable of helping with everyday productivity while keeping user data under the user's control.

Some of the ideas behind the project include:

- Private, offline AI conversations
- Long-term memory
- Local document understanding
- Retrieval-Augmented Generation (RAG)
- Multiple AI provider support
- Modular architecture
- Extensible feature system
- Desktop-first user experience

Everything is designed with a local-first philosophy.

---

# Current Features

## AI Chat

- Offline chat using Ollama
- Streaming AI responses
- Multiple local model support
- Chat history
- Conversation management
- Markdown rendering

## Memory (Foundation)

- Local memory storage
- Basic memory extraction
- Memory management architecture

## Documents

- Local document attachment
- Text extraction
- PDF support
- Foundation for document understanding

## RAG (Foundation)

- Document chunking
- Vector store
- Retrieval pipeline
- Embedding abstraction

## Desktop Experience

- Flutter desktop interface
- Dark theme
- Conversation sidebar
- Message actions
- Local persistence

---

# Architecture

Era follows a feature-first architecture with clear separation between UI, business logic, repositories, and AI providers.

```
lib/
│
├── core/
│   ├── ai/
│   ├── theme/
│   └── utilities/
│
├── features/
│   ├── chat/
│   ├── memory/
│   ├── documents/
│   ├── rag/
│   └── settings/
│
└── main.dart
```

The architecture is intentionally modular so future providers, tools, and features can be added without major changes.

---

# Technologies

- Flutter
- Dart
- Ollama
- SharedPreferences
- Provider
- Markdown
- Syncfusion PDF

---

# Installation

## Prerequisites

- Flutter (latest stable)
- Dart SDK
- Ollama
- Git

Clone the repository:

```bash
git clone https://github.com/ganeshlondhe1012/era1.git
cd era1
```

Install dependencies:

```bash
flutter pub get
```

Start Ollama:

```bash
ollama serve
```

Download a model:

```bash
ollama pull phi3:mini
```

Run Era:

```bash
flutter run -d windows
```

---

# Quick Start

1. Launch Ollama.
2. Open Era.
3. Select an installed model.
4. Start chatting.
5. Optionally attach documents.
6. Everything remains local.

No API keys are required.

---

# Current State

Era is still under active development.

Although the application already provides a functional offline chat experience, many parts of the architecture are intentionally designed as foundations for future features.

Some systems currently have simple implementations that will become more advanced over time.

Examples include:

- Prompt engineering
- Memory retrieval
- RAG quality
- Context management
- AI validation

The current focus is on building a solid foundation before expanding functionality.

---

# Code Quality

The current codebase is functional and actively being improved.

As I continue learning software architecture and Flutter development, I'm gradually refactoring existing code to make it cleaner, more modular, and easier to maintain.

Rather than rewriting everything at once, I prefer improving the project incrementally while keeping it functional.

---

# Roadmap

Some planned improvements include:

## Chat

- Better prompt engineering
- Conversation summaries
- Edit messages
- Better Markdown rendering

## Memory

- Semantic memory retrieval
- Memory ranking
- Memory editing
- Automatic cleanup

## Documents

- Better PDF support
- DOCX support
- Improved indexing
- Better retrieval

## AI

- Tool calling
- Multi-model support
- Better context handling
- Response validation

## Long-Term Vision

- Local AI workspace
- Agents
- Voice interaction
- Vision models
- Plugin system
- Workspace management

More details are available in `ROADMAP.md`.

---

# Contributing

Contributions, ideas, bug reports, and suggestions are always welcome.

If you'd like to contribute, please read `CONTRIBUTING.md` before opening an issue or pull request.

---

# Acknowledgements

Era is primarily a personal learning project.

Although I built the application myself, I also relied on external learning resources throughout development, including:

- Official Flutter documentation
- Dart documentation
- Ollama documentation
- Open-source projects
- Technical articles
- ChatGPT for learning, brainstorming, debugging, and architectural guidance

These resources helped me understand concepts and improve the project while continuing to learn.

---

# License

This project is licensed under the MIT License.

See the `LICENSE` file for details.

---

# Final Note

Era is not a finished product.

It's a project that grows as I learn.

Some parts are polished, others are still evolving, and many ideas remain experimental.

Instead of waiting until everything is "perfect," I wanted to make the project public so people can follow its progress, provide feedback, and hopefully learn alongside me.

If you find something that can be improved, have an idea, or simply want to share feedback, I'd genuinely appreciate it.

Thanks for checking out Era.