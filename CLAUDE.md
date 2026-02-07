# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Ralph Wiggum** project template using a **Planner-Executor** model:
- **Planner**: Claude Code or other capable models (planning, architecture, detailed specifications)
- **Executor**: Local LLM (Qwen3-Coder-Next-UD-Q4_K_XL.gguf or similar) for code implementation

The planner must provide **highly detailed, explicit instructions** because the executor model has limited context and reasoning capabilities.

## Ralph Wiggum Workflow

This project uses the Ralph Wiggum AI Agent technique - an autonomous AI coding workflow that runs in a continuous loop with fresh context each iteration.

### Quick Start

```bash
# 1. Generate implementation plan (planner mode)
./loop.sh plan

# 2. Start building (executor mode)
./loop.sh build

# 3. Limit iterations (optional)
./loop.sh build 10
```

### Key Files

| File | Purpose |
|------|---------|
| `PROMPT_plan.md` | Instructions for planner mode (Claude) |
| `PROMPT_build.md` | Instructions for executor mode (Local LLM) |
| `AGENTS.md` | Operational guide (how to build/test/run) |
| `IMPLEMENTATION_PLAN.md` | Prioritized task list |
| `specs/` | Detailed specifications |

## Planner-Executor Model

### Planner Responsibilities (Claude Code)
- Understand requirements and constraints
- Design architecture and data models
- Break down work into atomic tasks
- Write **extremely detailed** task descriptions
- Provide **complete code examples** in tasks
- Include **exact file paths** and **line numbers** where possible
- Write **test cases first** (TDD approach)
- Update plan as project evolves

### Executor Responsibilities (Local LLM)
- Follow task instructions exactly
- Write tests first, then implementation
- Run build/test validation
- Mark tasks complete
- Commit changes
- Update AGENTS.md with operational learnings

### Critical: Bridging the Capability Gap

The executor model has **limited context window** and **weaker reasoning**. The planner MUST:

1. **Be Explicit**: Don't assume the executor knows anything. Spell out every detail.
2. **Provide Examples**: Include complete code snippets, not just descriptions.
3. **One Task Per Iteration**: Each task must be completable in one session.
4. **Include File Paths**: Always specify exact paths for files to create/modify.
5. **Write Tests First**: Include the complete test code in the task.
6. **Validation Steps**: Tell executor exactly how to verify their work.

## Build & Development Commands

<!-- Update these based on your project's language/framework -->

### Generic Commands (Update for your language)
- Build: `[your build command]`
- Test: `[your test command]`
- Lint: `[your lint command]`
- Run: `[your run command]`

## Test-First Development (TDD)

Every feature follows this cycle:
1. Write failing test → RED
2. Write minimal code → GREEN
3. Refactor → CLEAN
4. Commit

## Architecture

<!-- Document high-level architecture decisions as the codebase grows -->

See `specs/` directory for detailed specifications.

## Local LLM Configuration

The executor LLM is accessible at:
- **URL**: https://fedora-manor.tail356fe.ts.net/
- **Model**: Qwen3-Coder-Next-UD-Q4_K_XL.gguf
- **Access**: Private network via Tailscale (not public)

## Resources

- [Ralph Wiggum Technique](https://ghuntley.com/ralph)
- [Geoffrey Huntley's Guide](https://github.com/ghuntley/how-to-ralph-wiggum)
