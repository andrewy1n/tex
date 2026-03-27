# Development container for LaTeX multi-project workspace
# Includes TeX Live distribution with common utilities and Node.js

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    make \
    perl \
    python3 \
    openssh-client \
    sudo \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install TeX Live (core packages for LaTeX compilation)
# Using a curated set of texlive packages instead of texlive-full to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-xetex \
    latexmk \
    chktex \
    latexdiff \
    texlive-extra-utils \
    && rm -rf /var/lib/apt/lists/*

# latexindent: use apt (texlive-extra-utils). Ubuntu's TeX Live often does not expose a
# working tlmgr user install that puts latexindent on PATH for non-root users.

# Install Node.js LTS (for VSCode/Cursor server and future tooling)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user for development with explicit UID matching local user
RUN useradd -m -s /bin/bash -u 1000 vscode && \
    mkdir -p /workspace && \
    chown vscode:vscode /workspace

# Allow vscode to fix bind-mount ownership (host files) via postStartCommand only
COPY fix-workspace-perms.sh /usr/local/bin/fix-workspace-perms.sh
RUN chmod +x /usr/local/bin/fix-workspace-perms.sh && \
    echo 'vscode ALL=(root) NOPASSWD: /usr/local/bin/fix-workspace-perms.sh' \
      > /etc/sudoers.d/vscode-workspace && \
    chmod 0440 /etc/sudoers.d/vscode-workspace

# Set working directory
WORKDIR /workspace

# Set the default user
USER vscode

# Verify LaTeX tools are available
RUN latexmk --version && chktex --version && latexdiff --version && latexindent --version
