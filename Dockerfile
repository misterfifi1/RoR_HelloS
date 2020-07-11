FROM ruby:latest
ADD . /usr/src/app/
WORKDIR /usr/src/app/


RUN gem install bundler
RUN bundle install

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get upgrade -y && \
  apt-get install --no-install-recommends -y ca-certificates nodejs yarn

RUN yarn install
RUN ls -lsa
EXPOSE 3333
CMD ["ruby", "bin/rails server -b 0.0.0.0 -p 3000 -e development"]