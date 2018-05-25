# docker-e2e

[![WTFPL License](https://img.shields.io/badge/license-wtfpl-blue.svg)](http://www.wtfpl.net/about/)
[![Build Status](https://travis-ci.org/lictw/docker-e2e.svg?branch=master)](https://travis-ci.org/lictw/docker-e2e)

This is simple web application, written in **go**,
provisioned by **docker** with **docker-compose** and covered with **e2e tests** via **robot framework**, **selenium** and **travis-ci**.

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

