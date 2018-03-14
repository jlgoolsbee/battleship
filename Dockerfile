FROM ruby:2.5.0-alpine

WORKDIR /tmp/battleship

COPY . ./

RUN bundle install
RUN bundle exec rake test

CMD ["ruby", "battleship.rb"]
