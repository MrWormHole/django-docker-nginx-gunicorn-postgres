## Create database user and project database

SSH into the database container and create user and database there with the same values as in the `.build_dev.sh` script:

```bash
$ docker exec -it django_docker_db_1 bash
/# su - postgres
/$ createuser --createdb --password myproject
/$ createdb --username myproject myproject
```

When asked, enter the same password for the database as in the `build_dev.sh` script.

## Run migration and collectstatic commands

SSH into the gunicorn container and run the necessary Django management commands:

```bash
$ docker exec -it django_docker_gunicorn_1 bash
$ source env/bin/activate
(env)$ python manage.py migrate
(env)$ python manage.py collectstatic
(env)$ python manage.py createsuperuser
```

Answer all the questions asked by the management commands.

Press [Ctrl + D] twice to logout of the Docker container.

If you now go to `http://0.0.0.0/admin/`, you should see the Django administration where you can login with the super user's credentials that you have just created.

## 6. Overview of useful commands


### SSH to the Docker containers

```bash
$ docker exec -it django_docker_gunicorn_1 bash
$ docker exec -it django_docker_nginx_1 bash
$ docker exec -it django_docker_db_1 bash
```

### View logs

```bash
$ docker-compose logs nginx
$ docker-compose logs gunicorn
$ docker-compose logs db
```

### Copy files and directories to and from Docker container

```bash
$ docker cp ~/avatar.png django_docker_gunicorn_1:/home/myproject/media/
$ docker cp django_docker_gunicorn_1:/home/myproject/media ~/Desktop/
```
