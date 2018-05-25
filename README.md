# docker-e2e

[![WTFPL License](https://img.shields.io/badge/license-wtfpl-blue.svg)](http://www.wtfpl.net/about/)
[![Build Status](https://travis-ci.org/lictw/docker-e2e.svg?branch=master)](https://travis-ci.org/lictw/docker-e2e)

This is a simple web application, written in **go**, provisioned by **docker** with **docker-compose** and covered with **end-to-end tests** via **robot framework**, **selenium** and **travis-ci**. Also **nginx** used as frontend HTTP(-S) server.

## Usage
Use docker-compose command to manage the application, for example, start it with the command:
```
docker-compose up
```

## Test
If the command below ends with zero exit code - everything is fine!
```
make test
```
To start tests on local setup run command: (all from *./tests/requirements.txt* and **chromedriver** should be installed, and web application must be running)
```
make test-local
```
