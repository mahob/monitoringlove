# Monitoring Love <3

After seeing the [Grafana 5 Preview](https://www.youtube.com/watch?v=BC_YRNpqj5k) and after reading the Grafana blog post [Graphite 1.1: Teaching an Old Dog New Tricks](https://grafana.com/blog/2018/01/11/graphite-1.1-teaching-an-old-dog-new-tricks/?utm_source=blog&utm_campaign=graphite) I wanted desperately to test the new features of Grafana and Graphite. This is why I created a nice composition of a couple of Dockerfiles and Docker containers (see [docker-compose.yml](https://github.com/mahob/monitoringlove/blob/master/docker-compose.yml)):

- The Grafana container (see [Dockerfile](https://github.com/mahob/monitoringlove/blob/master/Dockerfile))
- The Postgres container (see [Dockerfile-postgres](https://github.com/mahob/monitoringlove/blob/master/Dockerfile-postgres))
- The Graphite container (see [Dockerhub - graphiteapp/graphite-statsd/](https://hub.docker.com/r/graphiteapp/graphite-statsd/))
- The container writing data to the Graphite container (see [Dockerfile-graphite-writer](https://github.com/mahob/monitoringlove/blob/master/Dockerfile-graphite-writer))

# License
MIT (see LICENSE)