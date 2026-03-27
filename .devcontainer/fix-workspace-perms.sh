#!/usr/bin/env sh
set -e
# Bind-mounted workspace files may be root-owned on the host (e.g. sudo edits,
# mis-cloned submodules). Align ownership with the dev container user so saves work.
exec chown -R vscode:vscode /workspace
