# dockerfile-showoff #
Showoff dockerfile with all options for showoff

Volume given is /srv/showoff

## Exemple of use with puppetlabs examples ##
Getting docker image:

``` shell
docker pull wanix/showoff
```

Getting puppetlabs examples

``` shell
cd /tmp && git clone https://github.com/puppetlabs/showoff.git
```

Serving Puppetlabs examples:

``` shell
docker run -d -p 9090:9090 -P -h showoff --name showoff -v /tmp/showoff/example:/srv/showoff wanix/showoff
```

Now you can connect on the port 9090 of your server with your favorite browser to see the result

Generating pdf:

``` shell
docker exec -it showoff /bin/sh -c 'cd /srv/showoff && showoff pdf'
```

The pdf generation is broken with pictures in presentation (showoff 0.0.12) : https://github.com/puppetlabs/showoff/pull/442

## building ##

``` shell
git clone https://github.com/wanix/dockerfile-showoff.git 
cd dockerfile-showoff
```

Without proxy in your network:

``` shell
docker build -t wanix/showoff .
```

With a proxy in your network:

``` shell
docker build --build-arg http_proxy="http://proxy.example.com:3128" -t wanix/showoff .
```

## Licence ##
[Apache Licence V2](LICENSE)
