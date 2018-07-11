# define base image
FROM ubuntu:latest
# set workdir
WORKDIR /workdir
# install dependencies
RUN apt-get update
RUN apt-get install -y build-essential wget make ruby-dev
# download & install redis
RUN wget http://download.redis.io/releases/redis-4.0.10.tar.gz
RUN tar xvzf redis-4.0.10.tar.gz
RUN rm redis-4.0.10.tar.gz
WORKDIR ./redis-4.0.10
RUN make install
# install redis driver for ruby to be used in redis-trib.rb
RUN gem install redis
# execute redis
CMD redis-server --protected-mode no --port 7000
# expose port
EXPOSE 7000