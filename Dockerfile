FROM arm32v6/ruby:2.5-alpine

RUN apk add --update \
  bash \
  build-base \
  nodejs \
  postgresql-client \
  postgresql-dev \
  sqlite-dev \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /usr/src/app/tmp/db
WORKDIR /usr/src/app
COPY Gemfile* /usr/src/app/
RUN cd /usr/src/app && bundle install
COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

