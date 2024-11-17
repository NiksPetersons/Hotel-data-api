## Hotel data API app

### What the application does
- Fetches hotel data in cities using openstreetmap.org data
- Stores hotel data locally
- Allows to search through simple hotel data locally

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


