FROM mcr.microsoft.com/devcontainers/base:jammy

ENV PICO_SDK_VERSION 1.5.0

RUN apt update \
    && apt install -y --no-install-recommends build-essential cmake gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
    && rm -rf /var/lib/apt/lists/* /var/log/apt/* /var/log/dpkg.log /var/log/alternatives.log /var/cache/

RUN git clone -b ${PICO_SDK_VERSION} https://github.com/raspberrypi/pico-sdk.git /opt/pico-sdk \
    && git -C /opt/pico-sdk submodule update --init

ENV PICO_SDK_PATH /opt/pico-sdk
