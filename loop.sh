#!/bin/bash

# Ralph Wiggum Loop Script
# Usage: ./loop.sh [mode] [max_iterations]
#   mode: build (default) or plan
#   max_iterations: optional limit (default: infinite)

set -euo pipefail

MODE="${1:-build}"
MAX_ITERATIONS="${2:-0}"
ITERATION=0

PROMPT_FILE="PROMPT_${MODE}.md"

# ============================================
# CONFIGURATION - Edit these for your setup
# ============================================

# For PLANNING mode (uses smarter model)
PLANNER_MODEL="claude-opus-4"  # Or: "gpt-4", "claude-sonnet-4", etc.

# For BUILDING mode (uses local LLM)
# Option 1: Local LLM via OpenAI-compatible API
EXECUTOR_API_BASE="https://fedora-manor.tail356fe.ts.net/v1"
EXECUTOR_MODEL="Qwen3-Coder-Next-UD-Q4_K_XL"

# Option 2: If using a different tool, update the command below

# ============================================

if [[ ! -f "$PROMPT_FILE" ]]; then
    echo "Error: $PROMPT_FILE not found"
    exit 1
fi

# Read the prompt file content
PROMPT_CONTENT=$(cat "$PROMPT_FILE")

echo "Ralph Wiggum AI Agent - Mode: $MODE"
echo "========================================"

if [[ "$MODE" == "plan" ]]; then
    echo "Model: $PLANNER_MODEL (Planner)"
    MODEL="$PLANNER_MODEL"
else
    echo "Model: $EXECUTOR_MODEL (Executor)"
    echo "API Base: $EXECUTOR_API_BASE"
    MODEL="$EXECUTOR_MODEL"
fi

echo ""

if [[ $MAX_ITERATIONS -gt 0 ]]; then
    echo "Max iterations: $MAX_ITERATIONS"
else
    echo "Running until interrupted (Ctrl+C to stop)"
fi

echo ""
echo "Press Enter to start Ralph (or Ctrl+C to cancel)..."
read -r

while true; do
    ITERATION=$((ITERATION + 1))

    echo ""
    echo "--------------------------------------------"
    echo "Iteration $ITERATION - $(date '+%Y-%m-%d %H:%M:%S')"
    echo "--------------------------------------------"
    echo ""

    # Choose which tool to use based on mode
    if [[ "$MODE" == "plan" ]]; then
        # Planning mode uses Claude Code directly
        # Adjust this command based on your setup
        claude --model "$MODEL" \
            --print \
            "$PROMPT_CONTENT" || {
            echo ""
            echo "Planner exited with error (code: $?). Continuing to next iteration..."
            echo ""
        }
    else
        # Building mode uses local LLM
        # Option A: Using Claude Code with custom API base (if supported)
        # Option B: Using a different CLI tool like 'opencode', 'aider', etc.
        # Option C: Direct API call

        # Example using opencode (adjust based on your tool):
        OPENAI_API_BASE="$EXECUTOR_API_BASE" \
        opencode run \
            -m "$MODEL" \
            --title "Ralph ${MODE} iteration ${ITERATION}" \
            "$PROMPT_CONTENT" || {
            echo ""
            echo "Executor exited with error (code: $?). Continuing to next iteration..."
            echo ""
        }
    fi

    echo ""
    echo "Iteration $ITERATION complete"

    # Push changes to remote after each iteration (optional)
    if git rev-parse --git-dir > /dev/null 2>&1; then
        CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
        echo "Pushing changes to remote..."
        git push origin "$CURRENT_BRANCH" 2>/dev/null || {
            echo "Warning: git push failed (code: $?). Continuing..."
        }
    fi

    # Check if we've reached max iterations
    if [[ $MAX_ITERATIONS -gt 0 ]] && [[ $ITERATION -ge $MAX_ITERATIONS ]]; then
        echo ""
        echo "Reached maximum iterations ($MAX_ITERATIONS). Stopping."
        break
    fi

    # Small delay between iterations to avoid hammering
    sleep 2
done

echo ""
echo "Ralph is done!"
