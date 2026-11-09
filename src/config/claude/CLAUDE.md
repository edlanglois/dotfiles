# Sandbox placeholder files

When running sandboxed, untracked files like `.bashrc`, `.bash_profile`,
`.profile`, `.zshrc`, `.zprofile`, `.gitconfig`, `.ripgreprc`, `.mcp.json`,
`.idea`, `.vscode` and parts of `.claude/` may appear in the working directory.
They are placeholders the sandbox creates to block writes, not user files.
Don't report them as clutter, suggest ignoring or deleting them, or commit them.
Stage files by explicit path rather than `git add -A`.

# Posting as the user

When posting on GitLab (or similar) with the user's credentials, e.g. MR/issue
comments or thread replies, start the comment with this header (then a blank line):

> 🤖 **Posted autonomously by Claude Code**
