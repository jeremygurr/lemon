ARG ALPINE_IMAGE=alpine:latest

FROM $ALPINE_IMAGE

USER root

ARG NO_PROXY=""
ARG HTTPS_PROXY=""
ARG HTTP_PROXY=""
ARG ALPINE_REPO=https://dl-cdn.alpinelinux.org/alpine/

COPY repositories /etc/apk/
RUN sed -i "s@https://dl-cdn.alpinelinux.org/alpine/@$ALPINE_REPO@g" /etc/apk/repositories 
RUN apk update 

RUN apk add \
  alpine-conf \
  alpine-conf \
  apk-tools-doc \
  bash \
  bash-completion \
  bash-completion-doc \
  bash-doc \
  bind-tools \
  busybox-doc \
  ca-certificates-doc \
  coreutils \
  coreutils-doc \ 
  curl \
  curl-doc \
  dnsmasq \
  dnsmasq-doc \
  docs \
  expat-doc \
  file \
  file-doc \
  findutils \
  findutils-doc \
  fstrm-doc \
  git \
  git-doc \
  git-perl \
  grep \
  grep-doc \
  ifupdown-ng \
  ifupdown-ng-doc \
  jq \
  jq-doc \
  json-c-doc \
  less \
  less-doc \
  libcap-ng-doc \
  libeconf-doc \
  libedit-doc \
  libretls-doc \
  libxml2-doc \
  linux-pam-doc \
  man-pages \
  mandoc \
  mandoc-doc \
  net-tools \
  net-tools-doc \
  openrc \
  openrc-bash-completion \
  openrc-doc \
  openssh \
  openssh-doc \
  openssl \
  pcre-doc \
  pcre2-doc \
  perl \
  perl-doc \
  perl-error \
  perl-error-doc \
  perl-git \
  pkgconf-doc \
  procps \
  readline-doc \
  rsync \
  skalibs-doc \
  source-highlight \
  source-highlight-doc \
  strace \
  strace-doc \
  sudo \
  sudo-doc \
  tar \
  tar-doc \
  texinfo \
  texinfo-doc \
  tshark \
  tzdata \
  util-linux \
  util-linux-doc \
  util-linux-openrc \
  utmps-doc \
  utmps-openrc \
  vim \
  vim-doc \
  yq \
  zlib-doc \
  $nothing

# RUN apk add \
#   openssl3-doc \
#   $nothing

RUN apk add \
  helix \
  gcc \
  $nothing

ENV HOME /home
ENV PAGER less
ENV LEMON_HOME /lemon
ENV REPO_CACHE /home/.m2/repository

RUN adduser -h /home -s /bin/bash -D autouser -u 99999
RUN chmod a+rwx /etc
RUN ln -sf $LEMON_HOME/shell-start.sh /etc/profile.d/
RUN ln -sf $LEMON_HOME/inputrc /etc/
COPY sudoers /etc/
RUN chown root /etc/sudoers
RUN mkdir -p $REPO_CACHE

ARG TIME_ZONE=UTC
RUN setup-timezone -z $TIME_ZONE

WORKDIR /lemon
CMD /bin/bash $LEMON_HOME/init

