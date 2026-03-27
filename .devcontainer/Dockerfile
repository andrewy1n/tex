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
    && rm -rf /var/lib/apt/lists/*

# Install latexindent from CTAN via tlmgr (TeX Live package manager)
# First ensure tlmgr is available, then install latexindent
RUN tlmgr init-usertree && \
    tlmgr update --self --all && \
    tlmgr install latexindent 2>/dev/null || echo "latexindent may already be installed with texlive-extra"

# Install Node.js LTS (for VSCode/Cursor server and future tooling)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user for development
RUN useradd -m -s /bin/bash vscode && \
    mkdir -p /workspace && \
    chown vscode:vscode /workspace

# Set working directory
WORKDIR /workspace

# Set the default user
USER vscode

# Verify LaTeX tools are available
RUN latexmk --version && chktex --version && latexdiff --version && \
    (which latexindent > /dev/null || echo "Note: latexindent may not be in PATH but is available via Perl")
