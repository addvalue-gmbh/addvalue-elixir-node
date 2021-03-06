FROM ubuntu:18.04

LABEL maintainer="addvalue"
LABEL email="info@addvalue.de"
LABEL website="addvalue.de"
LABEL project_link="https://github.com/addvalue-gmbh/addvalue-elixir-node"
LABEL version="0.1.1"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install -y wget curl locales build-essential libpq-dev git inotify-tools apt-utils postgresql-client ca-certificates apt-transport-https ruby ruby-dev rubygems gcc g++ make
RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
RUN dpkg -i erlang-solutions_2.0_all.deb
RUN apt-get update -qq && apt-get install esl-erlang -y
RUN apt-get install elixir -y

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update 
RUN apt-get install -y nodejs yarn
RUN npm i npm@latest -g

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update -yqqq
RUN apt-get install -y google-chrome-stable > /dev/null 2>&1

RUN npm install -g ember-cli

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
