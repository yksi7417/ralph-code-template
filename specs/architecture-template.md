# Architecture Specification (Template)

## Overview

[Describe what this system does in 2-3 sentences]

Example:
> A high-performance order simulator that accepts concurrent orders and generates fills. The system cleanly separates transport logic from business logic, enabling easy switching between different messaging systems.

## Technology Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| Language | [e.g., Python 3.11] | Primary language |
| Build Tool | [e.g., Poetry] | Dependency management |
| Testing | [e.g., pytest] | Test framework |
| Linting | [e.g., ruff] | Code quality |

## Architecture Diagram

```
[ASCII diagram of system components]

Example:
┌─────────────────────────────────────────────────────────┐
│                    Application Layer                     │
│                                                          │
│  ┌─────────────────┐     ┌─────────────────────────┐   │
│  │   Transport     │     │      Business Logic      │   │
│  │   (Interface)   │────▶│      (Core Engine)       │   │
│  └─────────────────┘     └─────────────────────────┘   │
│           │                         │                    │
│           ▼                         ▼                    │
│  ┌─────────────────┐     ┌─────────────────────────┐   │
│  │  Concrete       │     │      Domain Model        │   │
│  │  Transports     │     │   (Entities, Values)     │   │
│  └─────────────────┘     └─────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

## Core Design Principles

### 1. [Principle Name]

**What**: [Description]
**Why**: [Rationale]
**How**: [Implementation approach]

Example:
### 1. Separation of Concerns

**What**: Transport layer is completely separate from business logic.
**Why**: Enables swapping messaging systems (HTTP, Kafka, etc.) without changing core logic.
**How**: Use interfaces/protocols for transport, inject concrete implementations.

### 2. [Principle Name]

...

## Core Components

### Component 1: [Name]

**Purpose**: [What does this component do?]

**Responsibilities**:
- Responsibility 1
- Responsibility 2

**Interface**:
```[language]
// Define the interface/protocol
interface ComponentName {
    method1(param: Type): ReturnType
    method2(param: Type): ReturnType
}
```

### Component 2: [Name]

...

## Data Flow

1. [Step 1 - e.g., "Request comes in through Transport"]
2. [Step 2 - e.g., "Transport converts to domain object"]
3. [Step 3 - e.g., "Domain object passed to Engine"]
4. [Step 4 - e.g., "Engine processes and returns result"]
5. [Step 5 - e.g., "Transport sends response"]

## Error Handling

| Error Type | Handling Strategy |
|------------|-------------------|
| Validation errors | Return error response with message |
| Transport failures | Log and retry with backoff |
| Internal errors | Log, return generic error, don't crash |

## Testing Strategy

| Test Type | Scope | Framework |
|-----------|-------|-----------|
| Unit tests | Individual classes | pytest |
| Integration tests | Components together | pytest |
| E2E tests | Full system | pytest |

## Success Criteria

1. [ ] All components have defined interfaces
2. [ ] Transport can be swapped without changing core logic
3. [ ] Test coverage > 80%
4. [ ] All error cases handled

## File Structure

```
project/
├── src/
│   ├── domain/           # Domain models
│   │   ├── __init__.py
│   │   ├── entity.py
│   │   └── values.py
│   ├── engine/           # Business logic
│   │   ├── __init__.py
│   │   └── processor.py
│   └── transport/        # Transport layer
│       ├── __init__.py
│       ├── interface.py
│       └── http.py
├── tests/
│   ├── domain/
│   ├── engine/
│   └── transport/
└── specs/
```
