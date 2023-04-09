# dev_env

## Simple Introduction

This is a repository storing the resources for creating a isolated development(or self study) environment using Docker.

Currently so far, This repository contains these resources:

1. A ubuntu container with miniconda3 installed and some packages for machine learning and data science installed
2. A mysql container with
3. Both containers inside the same network

This repository will be improved further with more resources (like mongodb etc) are added for development

**Note** : Currently this image was tested on macOS and might not work in other OS

**Note** : Docker must be installed and set-up on your environment

## How to set up your own environment using this repo

1. Download the repository using git

```sh
git clone https://github.com/QuakTH/dev_env.git
```

2. change your path to the cloned repo. And change the `.env_example`. If you are confused with the environment variables check the meaning below :

- USER_UID : A uid for the ubuntu user
- USER_PWD : A password for the ubuntu user
- SSH_PORT : A host Port for forwarding the development ssh port(which is noramlly 22)
- MYSQL_ROOT_PWD : A MySQL root user password
- MYSQL_USER : A MySQL user to create
- MYSQL_PASSWORD : A password for the MySQL user
- MYSQL_PATH : A host directory to link with the /var/lib/mysql folder inside the MySQL container for data consistency

**Note** : Remember that when you create a container using the `MYSQL_PATH` params the user information(passwords etc) will be set and cannot be changed if you create a another container using the same `MYSQL_PATH`

3. Run `docker compose`

```sh
docker compose up -d
```

## TODOs

- [ ] Create a directory for containing the scripts for the dev environment and connect the directory to the host directory
- [ ] Create examples of how to use the development environment to the README file
- [ ] Currently the ubuntu image uses the arm64 build when installing miniconda3. Create a script for installing different buils for different platform
- [ ] Remove the password ssh process and only use the key process
