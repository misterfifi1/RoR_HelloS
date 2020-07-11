FROM ruby:2.7

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app/

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

#yarn installer
RUN apt-get update && apt-get install -y nodejs --no-install-recommends

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

#gem installer
RUN bundle config --global frozen 1
RUN bundle config --local without "development test"
RUN bundle install

COPY . /usr/src/app/

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3000
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]