FROM ubuntu:16.04

LABEL maintainer="addvalue"
LABEL email="info@addvalue.de"
LABEL website="addvalue.de"
LABEL project_link="https://github.com/addvalue-gmbh/addvalue-node"
LABEL version="0.1.0"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install -y wget curl locales build-essential git inotify-tools apt-utils
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN npm i npm@latest -g

RUN apt-get update -qq && apt-get install -y wget curl locales build-essential libpq-dev git inotify-tools apt-utils postgresql-client
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update -qq && apt-get install esl-erlang -y
RUN apt-get install elixir -y

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update -yqqq
RUN apt-get install -y google-chrome-stable > /dev/null 2>&1

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
