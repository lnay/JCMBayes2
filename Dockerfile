FROM docker.io/dpokidov/imagemagick:7.1.0-57-ubuntu


RUN apt-get update
RUN apt-get install -y git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
RUN eval "$($HOME/.rbenv/bin/rbenv  init -)"
RUN $HOME/.rbenv/bin/rbenv -v
RUN $HOME/.rbenv/bin/rbenv install -l
RUN $HOME/.rbenv/bin/rbenv install 3.2.0
RUN $HOME/.rbenv/bin/rbenv global 3.2.0
RUN ls /root/.rbenv/versions/3.2.0/bin
RUN ls $HOME/.rbenv/
RUN ls $HOME/.rbenv/bin/
ENV PATH=/root/.rbenv/versions/3.2.0/bin:$PATH
ENV LD_LIBRARY_PATH=/root/.rbenv/versions/3.2.0/lib:$PATH
RUN ruby -v
# RUN  apt-get install libmagickwand-dev # this is imagemagick 6 (maybe too old)
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
