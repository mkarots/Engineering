#!/usr/bin/env bash
#
# GitHub workflow helper script
# Provides aliases and functions for common git/GitHub operations
#

set -o pipefail  # Catch errors in pipes

# Configuration
GITHUB_USERNAME="mkarots"
GITHUB_HOME="https://github.com/$GITHUB_USERNAME"

# Browser command (configurable for different platforms)
BROWSER_CMD="${BROWSER_CMD:-open}"  # 'open' for macOS, 'xdg-open' for Linux

#==============================================================================
# Git Aliases
#==============================================================================

alias g='git status'
alias gcp='git_commit_and_push'
alias gcm='git commit -m'
alias gcmain='git switch main'
alias gm='git merge'
alias gmm='git merge master'
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias gpl='git pull'
alias gph='git push'
alias gbc='git switch'           # Modern: use 'switch' instead of 'checkout'
alias gbcn='git switch -c'       # Modern: use 'switch -c' instead of 'checkout -b'
alias gb='git branch'
alias gba='git branch -av'       # Fixed: was chaining aliases
alias gbd='git branch -d'
alias gl='git log'
alias gd='git diff'
alias clone='git clone'
alias merge='git merge'

# Heroku aliases
alias gphm='git push heroku master'

#==============================================================================
# Helper Functions
#==============================================================================

# Check if current directory is inside a git repository
is_git_repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
}

# Get current branch name and set BRANCH_NAME global variable
# Returns 1 if not on a branch (detached HEAD)
get_branchname() {
    BRANCH_NAME=$(git symbolic-ref --short HEAD 2>/dev/null)
    return $?
}

# Get repository name and set REPO_NAME global variable
get_reponame() {
    local toplevel
    toplevel=$(git rev-parse --show-toplevel 2>/dev/null) || return 1
    REPO_NAME=$(basename "$toplevel")
}

# Get .git directory path and set REPO_ROOT global variable
get_repo_root() {
    local toplevel
    toplevel=$(git rev-parse --show-toplevel 2>/dev/null) || return 1
    REPO_ROOT="$toplevel/.git"
}

# Get repository owner/user and set REPO_USER global variable
# Handles both SSH (git@github.com:user/repo.git) and HTTPS (https://github.com/user/repo.git)
get_repo_user() {
    local url
    url=$(git remote get-url origin 2>/dev/null) || return 1
    
    # Extract user from both SSH and HTTPS URLs
    if [[ "$url" =~ github\.com[:/]([^/]+) ]]; then
        REPO_USER="${BASH_REMATCH[1]}"
        return 0
    fi
    
    return 1
}

# Check if remote branch exists for current branch
# Note: This checks if the branch exists on remote, NOT if a PR exists
remote_branch_exists() {
    if ! is_git_repo; then
        return 1
    fi
    
    get_repo_root || return 1
    get_branchname || return 1
    
    local remote_ref="$REPO_ROOT/refs/remotes/origin/$BRANCH_NAME"
    [[ -f "$remote_ref" ]]
}

#==============================================================================
# Main Functions
#==============================================================================

# Push current branch to origin (unless branch ends with _local)
git_push() {
    local non_push_suffix="_local"
    
    if ! get_branchname; then
        echo "⚠️  Not on a branch (detached HEAD state)" >&2
        return 1
    fi
    
    # Skip push if branch name ends with _local suffix
    if [[ "$BRANCH_NAME" == *"$non_push_suffix" ]]; then
        echo "ℹ️  Skipping push for local-only branch: $BRANCH_NAME"
        return 0
    fi
    
    echo
    echo "🚀🚀🚀 Pushing $BRANCH_NAME to origin"
    echo
    git push origin "$BRANCH_NAME"
}

# Stage all changes, commit with message, push, and optionally open GitHub
# Usage: git_commit_and_push "commit message"
git_commit_and_push() {
    local commit_msg="$1"
    local should_open_web=true
    
    # Validate commit message
    if [[ -z "$commit_msg" ]]; then
        echo "❌ Error: Commit message required" >&2
        echo "Usage: gcp \"your commit message\"" >&2
        return 1
    fi
    
    if [[ ${#commit_msg} -lt 3 ]]; then
        echo "❌ Error: Commit message too short (minimum 3 characters)" >&2
        return 1
    fi
    
    # Verify we're in a git repository
    if ! is_git_repo; then
        echo "❌ Error: Not in a git repository" >&2
        return 1
    fi
    
    # Get repository metadata
    get_branchname || {
        echo "❌ Error: Could not determine branch name" >&2
        return 1
    }
    
    get_repo_user || {
        echo "❌ Error: Could not determine repository owner" >&2
        return 1
    }
    
    get_reponame || {
        echo "❌ Error: Could not determine repository name" >&2
        return 1
    }
    
    # Stage all changes
    echo "📦 Staging changes..."
    git add -A || {
        echo "❌ Error: Failed to stage changes" >&2
        return 1
    }
    
    # Commit
    echo "💾 Committing: $commit_msg"
    git commit -m "$commit_msg" || {
        echo "❌ Error: Commit failed" >&2
        return 1
    }
    
    # Push
    git_push || {
        echo "❌ Error: Push failed" >&2
        return 1
    }
    
    # Open GitHub in browser
    if [[ "$should_open_web" == true ]]; then
        local github_url
        
        if [[ "$BRANCH_NAME" == "master" ]] || [[ "$BRANCH_NAME" == "main" ]]; then
            # Open main repository page
            github_url="https://github.com/$REPO_USER/$REPO_NAME"
        elif remote_branch_exists; then
            # Branch exists on remote - open PR page (may or may not exist)
            github_url="https://github.com/$REPO_USER/$REPO_NAME/pull/$BRANCH_NAME"
        else
            # New branch - open compare/PR creation page
            github_url="https://github.com/$REPO_USER/$REPO_NAME/compare/$BRANCH_NAME?expand=1"
        fi
        
        echo "🌐 Opening: $github_url"
        "$BROWSER_CMD" "$github_url" 2>/dev/null || {
            echo "⚠️  Could not open browser. URL: $github_url" >&2
        }
    fi
    
    echo "✅ Done!"
}

# Open current repository in browser
github_open() {
    if ! is_git_repo; then
        echo "❌ Error: Not in a git repository" >&2
        return 1
    fi
    
    get_reponame || {
        echo "❌ Error: Could not determine repository name" >&2
        return 1
    }
    
    local url="$GITHUB_HOME/$REPO_NAME"
    echo "🌐 Opening: $url"
    "$BROWSER_CMD" "$url" 2>/dev/null || {
        echo "⚠️  Could not open browser. URL: $url" >&2
    }
}

#==============================================================================
# Utility Functions
#==============================================================================

# Display help information
github_help() {
    cat << 'EOF'
GitHub Helper Script - Available Commands
==========================================

Aliases:
  g          - git status
  gcp        - git commit and push (with auto-open GitHub)
  gcm        - git commit -m
  gcmain     - git switch main
  gm         - git merge
  gmm        - git merge master
  glg        - pretty git log graph
  gpl        - git pull
  gph        - git push
  gbc        - git switch (branch)
  gbcn       - git switch -c (create new branch)
  gb         - git branch
  gba        - git branch -av (all branches, verbose)
  gbd        - git branch -d (delete branch)
  gl         - git log
  gd         - git diff
  clone      - git clone
  merge      - git merge

Functions:
  git_commit_and_push "msg"  - Stage all, commit, push, and open GitHub
  git_push                   - Push current branch to origin
  github_open                - Open current repo in browser
  github_help                - Show this help message

Special Features:
  - Branches ending with '_local' won't be pushed
  - Auto-opens GitHub PR/compare page after push
  - Handles both SSH and HTTPS remote URLs
  - Modern git commands (switch instead of checkout)

Configuration:
  GITHUB_USERNAME - Set your GitHub username
  BROWSER_CMD     - Browser command (default: 'open' for macOS)

EOF
}

# Export functions so they're available in subshells if needed
export -f is_git_repo
export -f get_branchname
export -f get_reponame
export -f get_repo_root
export -f get_repo_user
export -f remote_branch_exists
export -f git_push
export -f git_commit_and_push
export -f github_open
export -f github_help
