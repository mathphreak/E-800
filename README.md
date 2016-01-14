# README

> I'll be back.

This is the E-800 Evaluator.
It isn't going to kill Sarah Connor (probably); it's just going to evaluate your code.
Create assignments, submit code, and have it run.

## Organization

This is a Docker multi-container application maintained with Docker Compose.

Metadata is all in `docker-compose.yml`.

### Web UI

The Web UI, which is 80% or more of the code here, is all Rails.

### DB

This uses Postgres by default, but it probably wouldn't be hard to get it on MariaDB or whatever.
