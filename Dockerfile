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
