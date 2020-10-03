FROM ruby:2.7

ENV APP_HOME=/opt/app
RUN mkdir -p ${APP_HOME}
WORKDIR ${APP_HOME}
