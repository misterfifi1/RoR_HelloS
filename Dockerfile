FROM ruby:latest
ADD . /usr/src/app/
WORKDIR /usr/src/app/
#gem installer
RUN gem install bundler
RUN bundle install

#yarn installer
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get upgrade -y && \
  apt-get install --no-install-recommends -y ca-certificates nodejs yarn
RUN yarn install

RUN ls -lsa /bin

EXPOSE 3000
ENTRYPOINT ["ruby", "./bin/rails", "server"]