# Specifications Directory

This directory contains detailed specifications for the project. These files guide both the **Planner** (Claude) and **Executor** (Local LLM) in understanding what needs to be built.

## Purpose

Specs serve as the **source of truth** for requirements. They should be:
- **Complete**: Cover all aspects of the feature
- **Unambiguous**: One interpretation only
- **Testable**: Can be verified through tests

## Recommended Spec Files

### Core Specs (Create these based on your project)

| File | Purpose |
|------|---------|
| `architecture.md` | High-level system design, components, data flow |
| `domain-model.md` | Core entities, their fields, relationships |
| `api.md` | API endpoints, request/response formats |
| `testing-strategy.md` | Test categories, coverage goals, test patterns |

### Feature Specs (Add as needed)

| File | Purpose |
|------|---------|
| `feature-[name].md` | Detailed spec for a specific feature |

## Spec Template

When creating a new spec, use this template:

```markdown
# [Feature/Component] Specification

## Overview

Brief description of what this spec covers.

## Goals

- Goal 1
- Goal 2

## Requirements

### Functional Requirements

1. FR-1: [Requirement description]
2. FR-2: [Requirement description]

### Non-Functional Requirements

1. NFR-1: [Requirement description]

## Design

### Data Model

[Describe entities, fields, relationships]

### Behavior

[Describe how the system should behave]

### Error Handling

[Describe error cases and how to handle them]

## Examples

[Provide concrete examples of inputs and expected outputs]

## Success Criteria

- [ ] Criterion 1
- [ ] Criterion 2

## Open Questions

- Question 1?
- Question 2?
```

## For the Planner

When creating the IMPLEMENTATION_PLAN.md:
1. Read all specs thoroughly
2. Break down requirements into atomic tasks
3. Order tasks by dependency
4. Provide complete code examples based on specs
5. Include exact file paths

## For the Executor

When implementing:
1. Reference specs if you need to understand WHY something is done
2. But follow IMPLEMENTATION_PLAN.md for WHAT to do
3. The plan contains all the details you need
