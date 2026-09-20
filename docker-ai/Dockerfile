FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    git-lfs \
    nodejs \
    npm \
    unzip \
    build-essential \
    gcc \
    g++ \
    gdb \
    make \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://opencode.ai/install | bash \
    && ln -s "$HOME/.opencode/bin/opencode" /usr/local/bin/opencode

RUN curl -fsSL https://sh.rustup.rs | bash -s -- -y \
    && cp -r /root/.cargo /usr/local/cargo \
    && cp -r /root/.rustup /usr/local/rustup \
    && chmod -R a+rwX /usr/local/cargo /usr/local/rustup

ENV PATH="/usr/local/cargo/bin:$PATH" \
    CARGO_HOME=/usr/local/cargo \
    RUSTUP_HOME=/usr/local/rustup

RUN curl -fsSL https://bun.sh/install | bash \
    && cp -r /root/.bun /usr/local/bun \
    && chmod -R a+rwX /usr/local/bun

ENV PATH="/usr/local/bun/bin:$PATH"

ARG USER_NAME=user
ARG USER_UID=1000
ARG USER_GID=1000

SHELL ["/bin/bash", "-c"]

RUN if getent group "$USER_GID" >/dev/null && [[ "$(getent group "$USER_GID" | cut -d: -f1)" != "$USER_NAME" ]]; then \
        groupdel "$(getent group "$USER_GID" | cut -d: -f1)" || true; \
    fi \
    && if getent passwd "$USER_UID" >/dev/null && [[ "$(getent passwd "$USER_UID" | cut -d: -f1)" != "$USER_NAME" ]]; then \
        userdel -r "$(getent passwd "$USER_UID" | cut -d: -f1)" || true; \
    fi \
    && if ! getent group "$USER_GID" >/dev/null; then groupadd -g "$USER_GID" "$USER_NAME"; fi \
    && if ! id -u "$USER_NAME" >/dev/null 2>&1; then useradd -m -u "$USER_UID" -g "$USER_GID" -s /bin/bash "$USER_NAME"; fi

RUN apt-get update && apt-get install -y --no-install-recommends ripgrep sudo \
    && rm -rf /var/lib/apt/lists/* \
    && echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME \
    && chmod 0440 /etc/sudoers.d/$USER_NAME \
    && mkdir -p /tmp/target /usr/local/cargo/registry \
    && chown -R "$USER_UID:$USER_GID" /tmp/target /usr/local/cargo/registry

USER "$USER_NAME"

ENV HOME="/home/$USER_NAME"

COPY cargo-config.toml "$CARGO_HOME/config.toml"

WORKDIR /workspace

ENTRYPOINT ["opencode"]