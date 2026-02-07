@echo off
REM Ralph Wiggum Loop Script for Windows
REM Usage: loop.bat [mode] [max_iterations]
REM   mode: build (default) or plan
REM   max_iterations: optional limit (default: infinite)

setlocal enabledelayedexpansion

set "MODE=%~1"
if "%MODE%"=="" set "MODE=build"

set "MAX_ITERATIONS=%~2"
if "%MAX_ITERATIONS%"=="" set "MAX_ITERATIONS=0"

set "ITERATION=0"
set "PROMPT_FILE=PROMPT_%MODE%.md"

REM ============================================
REM CONFIGURATION - Edit these for your setup
REM ============================================

REM For PLANNING mode (uses smarter model)
set "PLANNER_MODEL=claude-opus-4"

REM For BUILDING mode (uses local LLM)
set "EXECUTOR_API_BASE=https://fedora-manor.tail356fe.ts.net/v1"
set "EXECUTOR_MODEL=Qwen3-Coder-Next-UD-Q4_K_XL"

REM ============================================

if not exist "%PROMPT_FILE%" (
    echo Error: %PROMPT_FILE% not found
    exit /b 1
)

echo Ralph Wiggum AI Agent - Mode: %MODE%
echo ========================================

if "%MODE%"=="plan" (
    echo Model: %PLANNER_MODEL% ^(Planner^)
    set "MODEL=%PLANNER_MODEL%"
) else (
    echo Model: %EXECUTOR_MODEL% ^(Executor^)
    echo API Base: %EXECUTOR_API_BASE%
    set "MODEL=%EXECUTOR_MODEL%"
)

echo.
if %MAX_ITERATIONS% GTR 0 (
    echo Max iterations: %MAX_ITERATIONS%
) else (
    echo Running until interrupted ^(Ctrl+C to stop^)
)

echo.
echo Press any key to start Ralph ^(or Ctrl+C to cancel^)...
pause >nul

:loop
set /a ITERATION+=1

echo.
echo --------------------------------------------
echo Iteration %ITERATION% - %date% %time%
echo --------------------------------------------
echo.

REM Read prompt file content
set "PROMPT_CONTENT="
for /f "usebackq delims=" %%a in ("%PROMPT_FILE%") do (
    set "PROMPT_CONTENT=!PROMPT_CONTENT!%%a "
)

if "%MODE%"=="plan" (
    REM Planning mode uses Claude Code
    claude --model %MODEL% --print "%PROMPT_CONTENT%"
) else (
    REM Building mode uses local LLM
    REM Adjust this command based on your setup
    set "OPENAI_API_BASE=%EXECUTOR_API_BASE%"
    opencode run -m %MODEL% --title "Ralph %MODE% iteration %ITERATION%" "%PROMPT_CONTENT%"
)

if errorlevel 1 (
    echo.
    echo Exited with error. Continuing to next iteration...
    echo.
)

echo.
echo Iteration %ITERATION% complete

REM Push changes to remote
git push origin HEAD 2>nul
if errorlevel 1 (
    echo Warning: git push failed. Continuing...
)

REM Check max iterations
if %MAX_ITERATIONS% GTR 0 (
    if %ITERATION% GEQ %MAX_ITERATIONS% (
        echo.
        echo Reached maximum iterations ^(%MAX_ITERATIONS%^). Stopping.
        goto :end
    )
)

REM Small delay
timeout /t 2 /nobreak >nul

goto :loop

:end
echo.
echo Ralph is done!
endlocal
