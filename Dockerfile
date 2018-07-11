# set base image
FROM redis:4.0.10
# install dependencies
RUN apt-get update
RUN apt-get install -y wget ruby-dev
RUN gem install redis -v 4.0.1
# set workdir
WORKDIR /workdir
# get redis-trib.rb used for managing cluster
RUN wget https://raw.githubusercontent.com/antirez/redis/4.0/src/redis-trib.rb
RUN chmod a+rx redis-trib.rb
# expose ports
EXPOSE 7000 17000
# run redis instance in cluster mode
CMD redis-server --port 7000 --cluster-enabled yes --cluster-config-file nodes.conf --cluster-node-timeout 5000; 