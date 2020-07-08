# use python3 docker image
FROM python:3

WORKDIR /usr/src/app

# download project (copy everything from project to workdir)
COPY sample-http-api/* ./
# install requirements
RUN pip install --no-cache-dir -r requirements.txt

# install uWSGI
RUN pip install --no-cache-dir uwsgi

# copy uWSGI config
COPY uwsgi.ini .

# open uWSGI port
EXPOSE 9090

# set entrypoint to start uwsgi
ENTRYPOINT [ "uwsgi", "--emperor", "uwsgi.ini" ]

# healthcheck is pinging 9090 port by HTTP wich should not return any error
HEALTHCHECK --interval=10s --timeout=3s --start-period=10s --retries=2 \
            CMD curl -f 127.0.0.1:9090 || exit 1
