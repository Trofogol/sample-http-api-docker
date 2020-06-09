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

# [later] set up container metrics for prometheus
# [later] made metrics 

# check that all copies are done correctly and uWSGI is in PATH
RUN pwd; ls -l; which uwsgi

# open uWSGI port
EXPOSE 9090
# [later] open metrics port

# set entrypoint to start uwsgi
ENTRYPOINT [ "uwsgi", "--emperor", "uwsgi.ini" ]

HEALTHCHECK --interval=10s --timeout=3s --start-period=10s --retries=2 \
            CMD curl -f 127.0.0.1:9090 || exit 1
