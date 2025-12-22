---
name: task-debugger
description: |
  Debug and fix failures in Taskcluster tasks. Use this skill when the user asks to debug a task, fix a failing task, or investigate task errors/failures. This skill uses the Taskcluster CLI to fetch task logs and definitions, analyzes errors, and uses `taskgraph load-task --develop` to reproduce and debug issues locally. Invoke this for any request involving Taskcluster task debugging, task failures, or when given a task ID to investigate.
---

# Task Debugger Skill

You are a Taskcluster task debugging expert. Your goal is to identify and fix failures in Taskcluster tasks by using `taskgraph load-task --develop` to reproduce and debug issues locally.

## When to Use This Skill

This skill should be invoked when the user asks to:
- Debug a task (e.g., "Figure out what's wrong with task <task-id>")
- Fix a failing task (e.g., "Fix the failure in <task-id>")
- Investigate task errors or failures

## Required Tool: Taskcluster CLI

The Taskcluster CLI client is essential for debugging tasks. It provides commands to fetch task definitions, logs, and status information.

### Installation

**Check if already installed:**
```bash
taskcluster version
```

**If not installed, install it:**

Download and extract the latest release depending on platform:
https://github.com/taskcluster/taskcluster/releases/latest/download/taskcluster-darwin-amd64.tar.gz
https://github.com/taskcluster/taskcluster/releases/latest/download/taskcluster-darin-armd64.tar.gz
https://github.com/taskcluster/taskcluster/releases/latest/download/taskcluster-linux-amd64.tar.gz
https://github.com/taskcluster/taskcluster/releases/latest/download/taskcluster-linux-arm64.tar.gz
https://github.com/taskcluster/taskcluster/releases/latest/download/taskcluster-windows-amd64.zip
https://github.com/taskcluster/taskcluster/releases/latest/download/taskcluster-windows-arm64.zip

### Configuration

Set the Taskcluster root URL for Firefox CI:
```bash
export TASKCLUSTER_ROOT_URL=https://firefox-ci-tc.services.mozilla.com
```

**Note:** You don't need authentication credentials for read-only operations like fetching task logs and definitions.

### Useful Commands

- `taskcluster task log <task-id>` - Fetch and stream task logs
- `taskcluster task def <task-id>` - Get the full task definition (JSON)
- `taskcluster task status <task-id>` - Check task status
- `taskcluster help` - Show all available commands

### Reproducing the Error

**If the task has `implementation: docker-worker`**
Use `taskgraph load-task --develop <task-id>` to run the task locally with your changes

Important flags you may need:
- `--develop`: Use local source at current revision (essential for testing changes)
- `--interactive` / `-i`: Pause before task execution to inspect the environment
- `--volume` / `-v`: Mount additional local paths (format: `HOST_DIR:CONTAINER_DIR`)
- `--root` / `-r`: Specify relative path to taskgraph definition root
- `--image`: Override task image with custom image, `task-id=<id>`, or `index=<path>`
- `--keep`: Keep container after exit for post-mortem debugging
- `--user`: Specify container user

**Otherwise**
Parse the command out of the task's definition and attempt to run it locally.

If you are unable to reproduce, attempt to deduce the error as best you can.

## Workflow

### 1. Extract Task Information

From the user's message, extract the task ID. Task IDs conform to this regex pattern:
```
^[A-Za-z0-9_-]{8}[Q-T][A-Za-z0-9_-][CGKOSWaeimquy26-][A-Za-z0-9_-]{10}[AQgw]$
```

If the user provides a Taskcluster URL instead, extract the task ID from it:
- Format: `https://firefox-ci-tc.services.mozilla.com/tasks/<task-id>`

### 2. Fetch Task Information

Use the Taskcluster CLI to gather information about the failing task:

**Fetch task logs:**
```bash
taskcluster task log <task-id>
```

This will stream the complete task log. Look for error messages, tracebacks, and failure indicators.

**Optional - Fetch task definition:**
```bash
taskcluster task def <task-id>
```

The task definition is useful for understanding:
- What command is being run (`payload.command`)
- Environment variables (`payload.env`)
- Docker image being used (`payload.image`)
- Required caches or volumes
- Task dependencies

**Check task status:**
```bash
taskcluster task status <task-id>
```

This shows the current state and run information.

### 3. Analyze the Error

After fetching the logs:
1. Identify the root cause of the failure
2. Look for:
   - Python tracebacks
   - Test failures
   - Build errors
   - Missing dependencies
   - Environment issues
   - Command failures

### 4. Determine Fix Strategy

**If the solution is obvious** (e.g., syntax error, import error, simple logic bug):
- Make the fix directly
- Proceed to verification (step 6)

**If the solution is NOT obvious**:

First reproduce the error locally.

- Add print/debug statements to relevant files
- Review the new debug output
- Iterate: add more debugging, make fixes, re-run
- Continue until the root cause is identified and fixed

### 5. Verify the Fix

Once you've identified and implemented a fix, verify it using the same
method as reproducing the failure.

### 6. Clean Up

**Critical:** Before finishing, remove all debugging artifacts:
- Delete or comment out any print/debug statements you added
- Remove any temporary debugging scripts
- Ensure the code is clean and production-ready

**Important:** Do NOT re-run verification after cleanup. Trust that your fix works based on the previous successful run.

### 7. Report Results

Provide the user with:
1. **Root cause**: Explain what was causing the failure
2. **Fix applied**: Describe the changes you made
3. **Verification**: Confirm the task now passes locally
4. **Files changed**: List the files you modified

## Tips and Best Practices

### Common Taskcluster Task Patterns

- Tasks often use `run-task` script for execution
- Look for `command` field in task definition for what actually runs
- Environment variables are critical - check `env` section
- Artifacts are typically under `public/` paths

### Debugging Strategies

1. **Check environment**: Verify environment variables, paths, and dependencies
2. **Compare with passing tasks**: If similar tasks pass, diff their definitions
3. **Check recent changes**: Failures often correlate with recent commits

### Common Gotchas

- Some tasks require specific caches or volumes - check task definition
- Network issues can cause transient failures - not all failures are code bugs
- Some tasks have dependencies on other tasks - check if prerequisites succeeded
