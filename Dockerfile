FROM arm64v8/python:3.11

RUN apt update && apt install -y \
    git cmake unzip zip \
    build-essential python3-dev \
    wget openjdk-11-jdk curl

# Bazelisk (auto-manages Bazel versions)
RUN curl -Lo /usr/local/bin/bazel https://github.com/bazelbuild/bazelisk/releases/latest/download/bazelisk-linux-arm64 \
    && chmod +x /usr/local/bin/bazel

WORKDIR /src
RUN git clone https://github.com/google/mediapipe.git
WORKDIR /src/mediapipe

RUN bazel build -c opt mediapipe/python:mediapipe_py_pb2

RUN python3 setup.py bdist_wheel
