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

# Use default ubuntu user (UID 1000) already present in Ubuntu 24.04
RUN mkdir -p /workspace && \
    chown ubuntu:ubuntu /workspace

# Set working directory
WORKDIR /workspace

# Set the default user
USER ubuntu

# Verify LaTeX tools are available
RUN latexmk --version && chktex --version && latexdiff --version && latexindent --version
