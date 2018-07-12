# set base image
FROM redis:4.0.10
# install dependencies
RUN apt-get update
RUN apt-get install -y wget ruby-dev supervisor
RUN gem install redis -v 4.0.1
# set workdir
WORKDIR /workdir
# get redis-trib.rb used for managing cluster
RUN wget https://raw.githubusercontent.com/antirez/redis/4.0/src/redis-trib.rb
RUN chmod a+rx redis-trib.rb
# copy supervisor config
COPY supervisord.conf /etc/supervisor/supervisord.conf
# expose ports
EXPOSE 7000 7001 7002 7003 7004 7005
# run redis instance in cluster mode, use tail to keep container open
CMD supervisord -c /etc/supervisor/supervisord.conf && \
    sleep 3 && \
    yes yes | ./redis-trib.rb create --replicas 1 0.0.0.0:7000 0.0.0.0:7001 0.0.0.0:7002 0.0.0.0:7003 0.0.0.0:7004 0.0.0.0:7005 && \
    tail -f /var/log/supervisor/redis*.log