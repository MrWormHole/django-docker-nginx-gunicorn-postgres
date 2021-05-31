FROM python:latest

ARG PROJECT_NAME=myproject
ARG SUBPROJECT_NAME=subproject

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir /var/www/${myproject}
WORKDIR /var/www/${myproject}

COPY . .
RUN pip3 install -r requirements.txt
RUN sudo chown www-data /var/www/${myproject}
RUN cd ${subproject}

# set this myproject.wsgi
CMD ["sh", "-c", "python manage.py collectstatic --no-input; python manage.py migrate; gunicorn myproject.wsgi --workers 3 --bind 0.0.0.0:8000"]
