## Levelpath backend take-home task

### Task
Analyze and improve this application based on the requirements below.

### What the application does
- Fetches hotel data in cities using openstreetmap.org data
- Stores hotel data locally
- Allows to search through simple hotel data locally

### Requirements, improvements needed
- Improve search speed, warmup doesn't need to happen on every search (see failing test)
- New feature: Allow to search through hotels in a specific city (see failing test)
- New feature: Allow to add "Coat of arms"(Ģērbonis) image url to City and expose it in search results
- Please refactor code to your liking (e.g. too much logic in the controller)
- Think about the tests written, what You can improve there? Do all tests make sense?

### Submitting
- Please bundle your homework using `git bundle create lp-be-homework.bundle --all`
- Attach bundle file to email and send as a reply to initial homework email
- We will then extract it using `git clone lp-be-homework.bundle` on our side

### Hints from us
- Base code is not good, provided tests aren't good either
- We encourage to modify existing tests and write a new ones
- We really like when TDD approach is used during live coding [https://www.youtube.com/watch?v=K6RPMhcRICE]
- When planning improvements and work, try to come up with the action plan first, that way we will be able to prioritize and concentrate on important things first


### What's inside docker compose?

#### App was created using
```bash
rails new . --api
```

#### To start rails server, on the host system run
```bash
./run.sh
```

#### To connect to running web container
```bash
./connect
```

#### Inside the container - DB setup
```bash
bundle exec rake db:create
```

For development environment, run migrations
```bash
bundle exec rake db:migrate
```

#### Run tests
```bash
bundle exec rspec
```

#### Notes

* rails is set to port 3300 in development environment, so the api endpoint will be located at `http://localhost:3300/api/search`
* If you are familiar with docker compose, feel free to ignore helper commands

---
version: 2024-04-23


