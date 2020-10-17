Forked from [kubernetes contrib]

# Usage

- [Usage](#usage)
  - [Without docker-compose using Webhook](#without-docker-compose-using-webhook)
  - [Without docker-dompose](#without-docker-dompose)
  - [With docker-compose](#with-docker-compose)
  - [With docker-compose using Webhook](#with-docker-compose-using-webhook)

## Without docker-compose using Webhook

You can use this sync with webhooks as well, you need to specfiy webhook variable.
The webhook variables is number. Where 0 means that you do not want to use webhooks and everything greater than 0 means you do want to use webhooks.
The __default__ value is __0__

```bash
docker volume create -d local --name website_sources

docker run --name git-sync -d  \
    -e GIT_SYNC_REPO=https://github.com/openweb-nl/website-static.git \
    -e GIT_SYNC_DEST=/git \
    -e GIT_SYNC_BRANCH=master \
    -e GIT_SYNC_REV=FETCH_HEAD \
    -e GIT_SYNC_WEBHOOK=1 \
    -v website_sources:/git openweb/git-sync:0.0.1

docker run --name nginx \
    -d -p 8080:80 -v website_sources:/usr/share/nginx/html nginx
```

## Without docker-dompose

```bash
docker volume create -d local --name website_sources

docker run --name git-sync -d  \
    -e GIT_SYNC_REPO=https://github.com/openweb-nl/website-static.git \
    -e GIT_SYNC_DEST=/git \
    -e GIT_SYNC_BRANCH=master \
    -e GIT_SYNC_REV=FETCH_HEAD \
    -e GIT_SYNC_WAIT=10 \
    -v website_sources:/git openweb/git-sync:0.0.1

docker run --name nginx \
    -d -p 8080:80 -v website_sources:/usr/share/nginx/html nginx
```

## With docker-compose

Create a file called docker-compose.yml with the following content.

```yml
version: "3"

services:
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - website_sources:/usr/share/nginx/html:z
    depends_on:
      - git-sync
    restart: always
  git-sync:
    image: openweb/git-sync:0.0.1
    environment:
      - GIT_SYNC_REPO= "https://github.com/openweb-nl/website-static.git"
      - GIT_SYNC_DEST= "/git"
      - GIT_SYNC_BRANCH= "master"
      - GIT_SYNC_REV= "FETCH_HEAD"
      - GIT_SYNC_WAIT= "10"
    volumes:
      - website_sources:/git:z
    restart: always
volumes:
  website_sources:
    driver: local
```

Then start the containers with running the following command

```bash
docker-compose up -d
```

## With docker-compose using Webhook

You can create a file called docker-compose.yml.

```yml
version: "3"

services:
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - website_sources:/usr/share/nginx/html:z
    depends_on:
      - git-sync
    restart: always
  git-sync:
    image: openweb/git-sync:0.0.1
    environment:
      - GIT_SYNC_REPO= "https://github.com/openweb-nl/website-static.git"
      - GIT_SYNC_DEST= "/git"
      - GIT_SYNC_BRANCH= "master"
      - GIT_SYNC_REV= "FETCH_HEAD"
      - GIT_SYNC_WEBHOOK "1"
    volumes:
      - website_sources:/git:z
    restart: always
volumes:
  website_sources:
    driver: local
```

Then start the containers with running the following command

    docker-compose up -d

[kubernetes contrib]: https://github.com/joemccann/dillinger
