# Summary
This is a Dockerfile for build Golang scratch images.

## docker-compose usage
This Dockerfile is originally planned to be used in Docker-compose projects, but it can be used where ever it can be fited. Docker-compose.yml and the project structure are described in the following examples.

#### project folder structure
```bash
project-root
|- go-app
|    |-src
|- other-go-app
|    |-src
|- Dockerfile
|- Docker-compose.yml
|- README.md
|- ..
```
#### docker-compose.yml
```yml
version: '3.8'
     
services:
    go-app:
        platform: linux/amd64
        build:
            context: ./
            args:
                - source_path=./go-app/src
    other-go-app:
        platform: linux/amd64
        build:
            context: ./
            args:
                - source_path=./other-go-app/src
```