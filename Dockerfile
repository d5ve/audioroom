FROM canyan/janus-gateway:latest

RUN apt-get -y update && \
	apt-get install -y \
		nginx coturn && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


COPY conf/janus/* /usr/local/etc/janus/
COPY conf/nginx/default /etc/nginx/sites-available/default
COPY html/ /var/www/html/

EXPOSE 80
EXPOSE 3478/udp
EXPOSE 10000-10200/udp

CMD ["sh","-c","turnserver & nginx && /usr/local/bin/janus"]
