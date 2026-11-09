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

# Writing for others

Documentation, MR/PR descriptions, comments, and similar writing must be concise,
simple and readable. Avoid walls of text and unnecessary detail: respect the
reader's time by including only what is useful for them to read.

# Comments describe the current state

Code comments and documentation must help the reader understand the system as it is
now, not the change that produced it. Don't narrate what the code used to do or no
longer does (e.g. "No debouncing here: the agent now..."); that history belongs in
commit messages and MR/PR descriptions. Exception: when historical behaviour still
matters to the reader, e.g. for backward compatibility.
