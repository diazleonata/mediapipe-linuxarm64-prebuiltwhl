FROM --platform=linux/arm64 python:3.11-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
  git curl wget unzip zip cmake build-essential protobuf-compiler \
  openjdk-17-jdk bash

# Install Bazelisk (Bazel launcher)
RUN curl -Lo /usr/local/bin/bazel \
  https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-arm64 && \
  chmod +x /usr/local/bin/bazel

# Set working directory
WORKDIR /mediapipe

# Clone MediaPipe
RUN git clone https://github.com/google/mediapipe.git . && \
    git submodule update --init --recursive

# Preload environment variables (optional)
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64

# Build Python wheel
RUN python3 setup.py bdist_wheel