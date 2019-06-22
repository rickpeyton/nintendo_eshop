FROM ruby:2.4
RUN apt-get update && apt-get -y install git procps
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
COPY lib/nintendo_eshop/version.rb ./lib/nintendo_eshop/
COPY Gemfile* ./
COPY nintendo_eshop.gemspec ./
RUN bundle
RUN bundle exec yard gems
ENV SHELL /bin/bash
