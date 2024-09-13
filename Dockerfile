FROM ruby:3.3.5-alpine3.20

RUN apk update && apk upgrade && apk --update add ruby ruby-irb ruby-json ruby-rake \
    ruby-bigdecimal nodejs ruby-io-console libstdc++ tzdata postgresql-client bash \
    && mkdir -p /app

ENV RAILS_LOG_TO_STDOUT true
ENV INSTALL_PATH /app

WORKDIR $INSTALL_PATH
COPY Gemfile Gemfile.lock $INSTALL_PATH

RUN apk --update add --virtual build-dependencies build-base ruby-dev \
    postgresql-dev libc-dev linux-headers  git && \
    gem update --system && \
    gem install bundler && \
    cd $INSTALL_PATH ; bundle install && \
    apk del build-dependencies

COPY . $INSTALL_PATH
EXPOSE 3000
CMD ["bundle", "exec", "./bin/dev"]
