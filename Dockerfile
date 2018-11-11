FROM ruby:2.5.3-alpine as builder

RUN apk add alpine-sdk

ENV BUILD_DIR /usr/build

RUN mkdir -p $BUILD_DIR
WORKDIR $BUILD_DIR
COPY Gemfile $BUILD_DIR/

RUN gem update --system --no-doc
RUN gem install bundler --no-ri --no-rdoc
RUN bundle install


FROM ruby:2.5.3-alpine

ENV APP_HOME /usr/src/app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN gem update --system --no-doc

COPY . $APP_HOME
COPY --from=builder /usr/build $APP_HOME/
COPY --from=builder /usr/build/Gemfile.lock $APP_HOME/
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /root/.bundle /root/.bundle

ENTRYPOINT ["bundle", "exec", "rake"]

CMD sh
