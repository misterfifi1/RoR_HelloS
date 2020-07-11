FROM ruby:2.7

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app/

# RAILS_ENV environment is set to production.
# RAILS_SERVE_STATIC_FILES is set to allow the app to serve static files
# RAILS_LOG_TO_STDOUT is set to log to standard out instead of a file.
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

# We have to install nodeJS iwhich is not available in the image
RUN apt-get update && apt-get install -y nodejs --no-install-recommends

# We copy these 2 files separately before the rest of the app.
# Any changes on the source code, except for these 2 files, won't trigger another bundle install.
# Due to caching, if Gemfile and Gemfile.lock are not changed, bundle install will be skipped.
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

#gem installer
RUN bundle config --global frozen 1
RUN bundle config --local without "development test"
RUN bundle install

COPY . /usr/src/app/

#some cleaning
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3000
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]