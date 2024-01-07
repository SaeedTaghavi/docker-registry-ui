### runninga docker registry
you can run the docker-compose file with the folloing command:
```
$  docker-compose up
```
you can use flag ` -d ` to run in detached mode
```
$  docker-compose up -d
```





### remove the unwanted images from docker registry
after removing images from docker-ui, you must run the following command inside the container to remove the remnant files:

```
/ #  registry garbage-collect -m /etc/docker/registry/config.yml
```



All the manifests for created images are in the following path
```
[host OS]:  ./registry/docker/registry/v2/repositories

[inside container]:  /var/lib/registry/docker/registry/v2/repositories 

```

you can move, or delete manifests in this path, the run ` garbage-collect `  command mentioned above to remove all the remnants.

it is better that you run ` garbage-collect ` command in a cronjob, add something like this to the crontab of the OS that is hosting the docker registry container:
```
0 2 * * * docker exec registry sh -c "registry garbage-collect -m /etc/docker/registry/config.yml"

```
