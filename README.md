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

### Executor

This is the logistically interesting part.
`/app/executor/Dockerfile` specifies a Docker container that will (eventually) monitor the database for new submissions.
If it finds one, it will (eventually) spawn off an Eyeball to run that submission and give back results.
Those results will be saved in the database and displayed in the UI.

### Eyeball

The Eyeball will (eventually) be a minimal Docker image that can be spawned to run a specific submission securely.

**Why is it called that?**

Well, Darth Vader's flagship is called the Executor.
It carries a complement of several TIE fighters.
The TIE/LN starfighter, which is the boring one, is referred to as an "eyeball" by Rebel pilots.
See, the Executor sends out individual "eyeball"s.
Get it?

Okay, so it's not great, but the other TIEs are "dupes," "squints," and "brights." None of those are any good, either.

**Why is this pun Star Wars when the application's name is a Terminator reference?**

I honestly don't know.
I feel weird about the inconsistency, and I'm still not sure that I like E-800 as a name.
Suggestions for anything are welcome.
