FROM docker.io/ruby:3.2

RUN  apt-get install libmagickwand-dev
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["ruby", "./main.rb"]


# TODO: build into smaller container:
# FROM docker.io/ruby:3.2-alpine
# RUN apk update && apk add --no-cache build-base # build dep for native gems
# RUN apk add imagemagick imagemagick-dev imagemagick-libs
