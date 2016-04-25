build:
		docker build -t wanix/showoff .
run:
		docker run -d -p 9090:9090 -P -h showoff --name showoff wanix/showoff
clean:
		docker rm -f showoff
log:
		docker logs -f showoff
port:
		docker port showoff 9090
enter:
		docker exec -it showoff /bin/sh
