# Agents Operational Guide

This file documents how to build, test, and run the project.

**Last updated**: Initial setup

## Project Overview

[PROJECT_DESCRIPTION - Update this with your project's description]

## Technology Stack

| Component | Technology |
|-----------|------------|
| Language | [LANGUAGE - e.g., Python 3.11+, Java 17+, TypeScript 5+] |
| Build Tool | [BUILD_TOOL - e.g., pip, Maven, npm] |
| Testing | [TEST_FRAMEWORK - e.g., pytest, JUnit 5, Jest] |
| Linter | [LINTER - e.g., ruff, Checkstyle, ESLint] |

## Prerequisites

- [Requirement 1 - e.g., Python 3.11 or higher]
- [Requirement 2 - e.g., pip or poetry]
- Git

## Project Structure

```
project-root/
├── src/                        # Implementation code
│   └── [package]/
├── tests/                      # Test code
├── specs/                      # Requirement specifications
├── AGENTS.md                   # This file
├── IMPLEMENTATION_PLAN.md      # Current task list
├── PROMPT_build.md             # Build mode instructions
├── PROMPT_plan.md              # Plan mode instructions
├── CLAUDE.md                   # Claude Code guidance
└── loop.sh                     # Ralph loop script
```

## How to Build

```bash
# Update these commands for your project

# Install dependencies
[dependency install command]

# Compile/Build (if applicable)
[build command]
```

## How to Test

```bash
# Run all tests
[test all command]

# Run specific test file
[test specific command]

# Run tests with verbose output
[test verbose command]

# Run tests with coverage
[coverage command]
```

## How to Run

```bash
# Run the main application
[run command]

# Run with debug mode
[debug command]
```

## How to Lint

```bash
# Run linter
[lint command]

# Auto-fix lint issues (if available)
[lint fix command]
```

## Development Workflow (Test-First)

1. **Write test first** - Create failing test in `tests/`
2. **Run test** - Verify it fails (RED)
3. **Write implementation** - Minimal code to pass test
4. **Run test again** - Verify it passes (GREEN)
5. **Refactor** - Clean up code while keeping tests green
6. **Commit** - `git add . && git commit -m "description"`
7. **Push** - `git push origin [branch]`

## Code Style

- Follow [LANGUAGE] conventions
- Package structure: `[package.structure]`
- Use meaningful names
- Keep classes/functions focused and small
- Prefer composition over inheritance

## Common Commands

```bash
# Initialize project (if needed)
[init command]

# Clean build artifacts
[clean command]

# Format code
[format command]

# Type check (if applicable)
[type check command]
```

## Troubleshooting

### Build Issues
- Ensure [LANGUAGE] is installed: `[version check command]`
- Ensure [BUILD_TOOL] is installed: `[tool version command]`
- Clear cache: `[cache clear command]`

### Test Issues
- Run single test to isolate: `[single test command]`
- Check test output in `[test output location]`
- Use verbose flag for debug output

### Common Errors

| Error | Solution |
|-------|----------|
| [Common error 1] | [Solution 1] |
| [Common error 2] | [Solution 2] |

## Notes for Ralph (Executor)

- Always run tests before committing
- If build fails, fix it before moving to next task
- Update this file when you discover new operational knowledge
- Keep tests fast - use mocks for external dependencies
- Follow the plan exactly - don't improvise

## Learnings Log

<!-- Ralph will add learnings here as the project progresses -->

### Iteration Learnings

_No learnings recorded yet. Ralph will update this section as issues are encountered and solved._
