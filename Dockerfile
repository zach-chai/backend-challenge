FROM ruby:2.7.1

ENV APP_HOME=/opt/app
RUN mkdir -p ${APP_HOME}
WORKDIR ${APP_HOME}

COPY Gemfile* ./
RUN bundle install
