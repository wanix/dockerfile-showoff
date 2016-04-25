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

## building ##

 ``` shell
 git clone https://github.com/wanix/dockerfile-showoff.git 
 cd dockerfile-showoff
 docker build -t wanix/showoff
 ```

