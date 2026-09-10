# Changelog

## v1.1.0

### Added

- RAG MVP for TXT and Markdown documents
- Ollama `nomic-embed-text` embedding integration
- Local persistent vector index
- Cosine-similarity retrieval
- Documents and Ask Documents screens
- RAG setup and architecture documentation

### Improved

- Shared Ollama service now supports embedding requests
- RAG dependencies are wired through Provider
- Document deletion also removes its indexed vectors


## v0.1.0

### Added

- Offline AI chat powered by Ollama
- Streaming AI responses
- Local chat history
- Conversation management
- Markdown rendering
- Memory foundation
- Document attachment support
- Initial RAG architecture
- AI provider abstraction
- Modular project architecture

### Improved

- Cleaner project structure
- Refactored chat pipeline
- Better separation of business logic and UI
- Improved desktop user interface

### Known Limitations

- Prompt engineering is still basic.
- Memory retrieval is rule-based.
- RAG pipeline is under active development.
- Some planned features are placeholders for future versions.
## 1.1.0 Audit Fixes

- Fixed RAG chunking type conversion for Dart's `clamp()` return type.
- Added runtime-safe validation for chunk size and overlap values.
- Typed the RAG streaming response as `Stream<AIResponseChunk>`.
- Removed machine-specific Flutter/Android generated configuration files from the repository package.
- Removed IDE metadata that should not be committed to the source repository.
- Clarified README setup, RAG scope, and runtime verification status.

## 1.1.0-audit-2

- Hardened cosine-similarity retrieval for empty/invalid inputs.
- Retrieval now keeps valid negative cosine scores so top-k selection is not silently empty.
- Added rollback when document metadata persistence fails after vector indexing.
- Added validation for non-positive retrieval limits.

## 1.1.0-audit-3

- Re-audited the complete project package for local import integrity, project hygiene, RAG wiring, and obvious compile-time hazards.
- Updated the sidebar version label to match the package version.
- Runtime Flutter build and live Ollama verification remain pending because the required runtimes are unavailable in the audit environment.


## 1.2.0-python-rag

- Moved the implemented RAG engine from Dart into a local Python FastAPI service.
- Added TXT/Markdown extraction, chunking, Ollama embeddings, SQLite vector persistence, cosine retrieval, and RAG generation in Python.
- Added Flutter HTTP integration for document upload, query, delete, clear, and source metadata.
- Synchronized Python backend document IDs with Flutter metadata for reliable deletion.
- Added Python unit tests for chunking and cosine similarity.
- Removed superseded Dart-only RAG engine files to avoid two competing retrieval implementations.
