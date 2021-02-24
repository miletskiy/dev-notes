# Welcome to Developer's notes

## Commands
    free -h

    scp -r centos@10.10.54.18:/etc/nginx/conf.d

    hostnamectl

    sudo killall -HUP mDNSResponder

    ps -fA | grep flask
    ps | grep manage.py
    kill -9 47151 47245

    ps -ef | grep 5433
    kill 91256

    ssh-add -l
    ssh-add -L

    ssh -fN -A -L 5433:10.12.50.15:5432 centos@10.12.50.15

    cp -R dev-notes /Users/miletskiy/Data/professional/dev_notes/

    pip install -r requirements/base.txt --use-feature=2020-resolver
    pip install "celery>4.4.2,<5.0.0"

    # List of all env variables:
    import os
    os.environ

    # Give the execution permission for user only:

    chmod +x ./import_db.zsh

    # Give the execution permission for user only:

    chmod u+x ./import_db.zsh

    find ~/Data/projects -iname '*'.sql


## SSH
    https://gist.github.com/Icebreaker454/edbfc1214c6b97b44e86189f1b726a93

    Forward Tunnel: map port from remote machine/network on local machine
    ssh -L $LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT $USER@$SERVER

    Reverse Tunnel: make local port accessable to remote machine
    ssh -R $REMOTE_PORT:$LOCAL_HOST:$LOCAL_PORT $USER@$SERVER


## Postgres SQL

[https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546](https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546)

    \du List of roles
    \c db_name  Connect to the db
    \dt List of tables
    \l List of databases

    createuser dependents_service_user -W -S -e -l -R -P -D -U miletskiy
    createuser dependents_service_user -W -S -e -l -R -P -d -U miletskiy (create db)

    createdb -e -E utf8 -O dependents_service_user -U miletskiy -W dependents_service_db Db_for_Dependents

    CREATE ROLE stats_service_user NOSUPERUSER CREATEDB NOCREATEROLE INHERIT LOGIN;
    ALTER USER stats_service_user WITH PASSWORD 's3cr3t';
    CREATE DATABASE stats_service_db OWNER stats_service_user ENCODING 'utf8';
    DROP DATABASE IF EXISTS test_prescriptions_service_db;

    ALTER USER ind_service_user WITH CREATEDB;
     or:
    ALTER ROLE dependents_service_user with CREATEDB;

    export PGPASSWORD='L3@n_Postgre_SU#'
    export PGUSER='postgres'
    unset PGPASSWORD

    Got an error recreating the test database: database "test_ind_service_db" is being accessed by other users
    DETAIL:  There are 2 other sessions using the database.


    REVOKE CONNECT ON DATABASE vital_signs_service_db FROM public;
    SELECT pid, pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'vital_signs_service_db' AND pid <> pg_backend_pid();
    GRANT CONNECT ON DATABASE vital_signs_service_db TO public;

    pg_dump -h $POSTGRES_HOST -U $POSTGRES_USER -F t -d $DB_NAME > dump.tar

    pg_restore --verbose --clean --no-acl --no-owner --host=localhost --dbname=vital_signs_service_db --username=vital_signs_service_user dump_vs.sql

    docker exec -it postgres_container_name psql your_connection_string
    docker-compose exec postgres bash



## Django

    python manage.py startapp pharmacy -v 3   # New app verbose mode

    python manage.py makemigrations core --name privacy_policy  # Create a named migration for one app

    python manage.py migrate core 0005  # Migrate to specific migration
    python manage.py migrate core zero  # Back to the initial DB state

    python manage.py showmigrations profiles  # Show information about migrations
    ./manage.py migrate --fake some_app

    python manage.py createsuperuser
    smiletskyi
    smiletskyi@intellias.com
    p@ssw0rd

    ./manage.py shell
    from django.conf import settings
    settings.API_GEE_YAKEEN_QUERY_BASE_URL


## Flask

    flask db init  # Initiation
    flask db migrate --message 'District model'
    flask db upgrade
    flask db history  # Show information about migrations

    driver = 'postgresql'
    username = 'vs_service_user'
    password = 's3cr3t_p@ss'
    host = 'localhost'
    port = '5432'
    db_name = 'vs_service_db'
    SQLALCHEMY_DATABASE_URI = f'{driver}://{username}:{password}@{host}:{port}/{db_name}'

    flask shell
    from flask import current_app
    current_app.config.get("SQLALCHEMY_DATABASE_URI")

## Links

[Connect to a VPN from the Command Line on Mac OS](https://dev.to/andreassiegel/connect-to-a-vpn-from-the-command-line-on-mac-os-1e26)

[Linux: systemctl — управление службами](https://rtfm.co.ua/linux-systemctl-upravlenie-sluzhbami/)


## Kubernetes

    kubectl --kubeconfig ~/Data/Intellias/keys/kube/unified describe pod vital-signs-service-production

    kubectl --kubeconfig ~/Data/Intellias/keys/kube/unified logs individual-service-production-b66cd84c-cd7fv --since=5m -f

    kubectl --kubeconfig ~/Data/Intellias/keys/kube/unified describe pod individual-service-production-b66cd84c-cd7fv

    watch "kubectl --kubeconfig ~/Data/Intellias/keys/kube/unified get pod -o wide | grep indi"

    kubectl --kubeconfig ~/Data/Intellias/keys/kube/unified cp scripts/migrate.py vital-signs-service-production-support-6bf69c5585-g5wtm:/app/migrate.py

    kubectl get pod | grep pres
    kubectx
    kubectx stg

    kubectl get pods | grep Evicted | awk '{print $1}' | xargs kubectl delete pod

## Git
    git revert HEAD~1
    git checkout <branch_name> <file_name>
    https://gist.github.com/jexchan/2351996
    https://help.github.com/en/github/using-git/removing-a-remote
    git reset --soft HEAD~1
    git reset --hard HEAD~3
    git config user.email "smiletskyi@intellias.com"
    git config user.name "Sergii Miletskyi"

    git tag -s -a 0.15.0 -m "v0.15.0"
    git push --tags
    git tag --delete 0.15.0
    git push --delete origin 0.15.0
    git diff 4bb1ff33  1f6e1e5c
    <!-- git diff 4bb1ff33~  1f6e1e5c -->
    git branch -d the_local_branch
    git push origin --delete the_remote_branch

    git grep <regexp> $(git rev-list --all)
    git grep assign_questionnaire $(git rev-list --all)
    git rev-list --all | xargs git grep assign_questionnaire

    git checkout <old_name>
    git branch -m <new_name>
    git push origin -u <new_name>
    git push origin --delete <old_name>
    [How To Rename a Local and Remote Git Branch](https://linuxize.com/post/how-to-rename-local-and-remote-git-branch/)


## Docker
    docker-compose up
    docker-compose up <service_name>
    docker-compose exec kong kong reload
        ports:
            - 15432:5432
        command: ["postgres", "-c", "log_statement=all"] # uncomment it to log all queries

    docker rm $(docker ps -a -q)

## Gitlab CI/CD
    CI_BUILD_NO_CACHE: yes

## Celery
    celery -A celery_app worker -l INFO -Q default,db_tasks -c 4 -B

## Heroku
    heroku login
    heroku logs --tail
    heroku ps -a tgbarber
    heroku ps:scale web=1
    heroku config
    heroku addons
    heroku pg
    heroku run bash
    heroku pg:psql postgresql-shallow-23238 --app tgbarber
    heroku config:set DEVELOPMENT=False
    heroku config:set DJANGO_LOG_LEVEL='DEBUG'
    heroku config:set ALL_LOG_LEVEL='INFO'
    heroku run python manage.py showmigrations
    heroku run python manage.py migrate
    heroku run python manage.py createsuperuser
    heroku run python manage.py set_bot_webhook
    heroku run make shell
    heroku run make webhook
    heroku config:set WEB_CONCURRENCY=1


# MkDocs

For full documentation visit [mkdocs.org](https://www.mkdocs.org).

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

## Project layout

    mkdocs.yml    # The configuration file.
    docs/
        index.md  # The documentation homepage.
        ...       # Other markdown pages, images and other files.
