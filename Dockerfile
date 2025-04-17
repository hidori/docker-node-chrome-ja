FROM node:lts-slim

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    ca-certificates \
    curl \
    unzip \
    && update-ca-certificates

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y \
    locales \
    fonts-noto-cjk \
    && sed -i -E 's/# (ja_JP.UTF-8)/\1/' /etc/locale.gen \
    && locale-gen ja_JP.UTF-8
ENV TZ=Asia/Tokyo
ENV LANG=ja_JP

RUN curl -o /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && DEBIAN_FRONTEND=noninteractive apt install -y /tmp/google-chrome-stable_current_amd64.deb \
    && rm /tmp/google-chrome-stable_current_amd64.deb

RUN apt autoremove -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
