FROM python:latest

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN mkdir -p /var/www/django-project
WORKDIR /var/www/django-project

COPY . .
RUN pip3 install -r requirements.txt
RUN chown www-data /var/www/django-project
WORKDIR /var/wwww/django-project/subproject 

CMD ["sh", "-c", "python manage.py collectstatic --no-input; python manage.py migrate; gunicorn subproject.wsgi --workers 3 --bind 0.0.0.0:8000"]
