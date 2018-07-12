# Docker Redis Cluster

This docs contains following sections:

- [`Why This Project`](#why-this-project)
- [`Start Cluster`](#start-cluster)
- [`Stop Cluster`](#stop-cluster)
- [`Run Redis CLI`](#run-redis-cli)
- [`Acknowledgements`](#acknowledgements)

---

## Why This Project

I'm total noob when it comes to docker & devops. Yet for some reason I need to be able to run redis cluster in docker for my dev environment.

So this project is the result of my learning experience towards installing redis cluster in docker. In the core, I use `supervisord` to spin up multiple redis instances in single container, then convert them to redis cluster using bash script running in `CMD` section at `Dockerfile`.

The reason why I choose to spin up multiple redis instances in single container rather than in the multiple one is simpy because I want to be able to access my redis cluster from host. If I spin up them from multiple container, I won't be able to do it since my redis client will always redirect me to another container using private ip. So the simplest solution I could think of is to spin up them from single instance thus I won't have trouble with redirection to private ip.

The client redirection itself is the inherent property of redis cluster. For more details please refer [here](https://redis.io/topics/cluster-tutorial#playing-with-the-cluster).

To spin up the container, I prefer using `docker-compose` instead of `docker stack`. The reason is simpy because it offers me more feature & flexibility. But we could also spin up the container using `docker stack`. In this project, I already prepared helper for both commands using `make`. Please read following sections for more details.

To build this project, I'm using docker version `18.03.1-ce` for Mac. The redis version I'm using is `4.0.10`.

[Back to Top](#docker-redis-cluster)

---

## Start Cluster

To start the cluster using `docker-compose`, we could use following helper command:

```bash
$> make up
```

To start the cluster using `docker stack`, we could use following helper command:

```bash
$> make start-swarm
```

[Back to Top](#docker-redis-cluster)

---

## Stop Cluster

To stop the cluster started using `docker-compose`, we could use following helper command:

```bash
$> make down
```

To stop the cluster started using `docker stack`, we could use following helper command:

```bash
$> make stop-swarm
```

[Back to Top](#docker-redis-cluster)

---

## Run Redis CLI

To run the internal `redis-cli` inside the container, we could use following helper command:

```bash
$> make run-cli
```

But this command only applies if we start our cluster using `docker-compose`.

We could also use `redis-cli` from host to connect with the cluster. Simply use following command to do that:

```bash
$> redis-cli -c -p 7000
```

[Back to Top](#docker-redis-cluster)

---

## Acknowledgements

I would like to thank a lot to [@thelinuxlich](https://github.com/thelinuxlich) for giving me starting point to start this project via his awesome [gist](https://gist.github.com/thelinuxlich/97779d91fb829beca381474f226ab388).

I would also like to thank [@Grokzen](https://github.com/Grokzen) for his awesome [project](https://github.com/Grokzen/docker-redis-cluster) which introduce me to the idea of using single container to spin up multiple redis instances so we could connect to our redis cluster from host.

In essence my project & his are doing the same thing (even the name is also coincidentally same 😂). But underneath, I personally think mine is much more easier to understand from the perspective of noob like myself 😅. But if you want richer features, please take a look at his project.

[Back to Top](#docker-redis-cluster)

---