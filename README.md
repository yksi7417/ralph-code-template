# Ralph Wiggum Project Template

A **language-agnostic project template** for autonomous AI coding using the **Ralph Wiggum** workflow with a **Planner-Executor** model.

## Overview

This template enables a two-model workflow:

| Role | Model | Purpose |
|------|-------|---------|
| **Planner** | Claude Code, GPT-4, etc. | Creates detailed implementation plans |
| **Executor** | Local LLM (Qwen3, etc.) | Implements code following the plan |

The key insight: **The planner creates extremely detailed instructions** so that a less capable executor model can successfully implement the code.

## Why This Approach?

1. **Cost Efficiency**: Use expensive smart models only for planning
2. **Privacy**: Keep code execution on your local/private LLM
3. **Speed**: Local LLMs have lower latency for iterative coding
4. **Control**: Run the executor on your own hardware

## Quick Start

```bash
# 1. Copy template to new project
cp -r ralph-code-template my-project && cd my-project

# 2. Write specs in specs/ directory

# 3. Generate implementation plan (uses Claude)
./loop.sh plan

# 4. Start building (uses local LLM)
./loop.sh build
```

See [QUICKSTART.md](QUICKSTART.md) for detailed setup instructions.

## Core Concepts

### The Ralph Wiggum Technique

An autonomous AI coding loop where each iteration:
1. Reads the plan
2. Picks one task
3. Implements it (tests first)
4. Validates (runs tests)
5. Commits
6. Repeats with fresh context

### Planner-Executor Model

The **Planner** (smart model) creates plans that are:
- **Extremely explicit** - Every detail spelled out
- **Include complete code** - Full test and implementation code
- **Atomic tasks** - Each completable in one iteration
- **Test-first** - Tests written before implementation

The **Executor** (local LLM) follows plans by:
- Copying code exactly as provided
- Running validation commands
- Marking tasks complete
- Documenting issues encountered

### Test-First Development (TDD)

Every feature follows:
1. **RED** - Write failing test
2. **GREEN** - Write minimal code to pass
3. **REFACTOR** - Clean up
4. **COMMIT** - Save progress

## File Structure

```
project/
├── CLAUDE.md                 # Claude Code guidance
├── AGENTS.md                 # How to build/test/run
├── IMPLEMENTATION_PLAN.md    # Prioritized task list
├── PROMPT_plan.md            # Instructions for planner
├── PROMPT_build.md           # Instructions for executor
├── config.yaml               # Model configuration
├── loop.sh / loop.bat        # Automation scripts
├── QUICKSTART.md             # Setup guide
├── specs/                    # Specifications
│   ├── architecture.md
│   ├── domain-model.md
│   └── testing-strategy.md
├── src/                      # Implementation code
└── tests/                    # Test code
```

## Key Files

| File | Purpose |
|------|---------|
| `PROMPT_plan.md` | Instructions for the planner model |
| `PROMPT_build.md` | Instructions for the executor model |
| `AGENTS.md` | Operational guide (build commands, troubleshooting) |
| `IMPLEMENTATION_PLAN.md` | Living document with all tasks |
| `specs/*.md` | Detailed specifications |
| `config.yaml` | Model and API configuration |

## Configuration

### Local LLM Setup

Edit `config.yaml` or `loop.sh` to configure your local LLM:

```yaml
executor:
  model: "Qwen3-Coder-Next-UD-Q4_K_XL"
  api_base: "https://fedora-manor.tail356fe.ts.net/v1"
```

Supported local LLM options:
- **llama.cpp server** (your current setup)
- **Ollama** (`http://localhost:11434/v1`)
- **LM Studio** (`http://localhost:1234/v1`)
- **vLLM** (`http://localhost:8000/v1`)

### Planner Model

The planner uses Claude Code by default:
```yaml
planner:
  model: "claude-opus-4"
  provider: "anthropic"
```

## Language Agnostic

This template works with any language:
- **Python** - pytest, pip/poetry
- **Java** - JUnit, Maven/Gradle
- **TypeScript** - Jest/Vitest, npm/pnpm
- **C++** - GoogleTest, CMake
- **C#** - xUnit, dotnet
- **Go** - testing, go build
- **Rust** - cargo test

Just update `AGENTS.md` with your language's commands.

## Best Practices from ralph-order-simulator

This template incorporates patterns from a successful 820-test Java project:

1. **Detailed tasks with code** - Every task includes complete code examples
2. **Priority-based organization** - Foundation → Core → Integration
3. **Architecture decisions documented** - AD-1, AD-2, etc.
4. **Validation after every task** - Never skip tests
5. **Learnings log in AGENTS.md** - Capture operational knowledge
6. **Atomic commits** - One task = one commit

## Success Criteria

A well-functioning Ralph project:
- [ ] All tasks in plan have complete code examples
- [ ] Each task is completable in one iteration
- [ ] Tests written before implementation
- [ ] Executor can follow plan without improvising
- [ ] AGENTS.md updated with learnings
- [ ] Commits after each task

## Resources

- [Ralph Wiggum Technique](https://ghuntley.com/ralph)
- [Geoffrey Huntley's Guide](https://github.com/ghuntley/how-to-ralph-wiggum)
- [Test-Driven Development](https://martinfowler.com/bliki/TestDrivenDevelopment.html)

## License

MIT

---

**Built for autonomous AI coding** - Let Ralph do the work while you do the thinking.
