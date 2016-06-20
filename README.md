# PhoenixElm

Docker containers for a phoenix application with elm and postgres

## Building the docker container

To build and run the docker container, you need
[docker-compose](https://docs.docker.com/compose/install/).
To keep the same file permission between the host and the container, the uid of
the current user needs to be set. That is why the `UID` environment variable is
exported. The following command builds the container:

```
export UID
docker-compose build
```

## Setting up


```bash
app_name=some_app_name
cd app
mix deps.get
cd apps
while [ true ] ; do echo no ; done | mix phoenix.new $app_name
cd ../..
scripts/elmify/elmify.sh app/apps/$app_name
```

## Run the container

The container can be run with `docker-compose`:

```bash
docker-compose up
```
It can be useful to also have another terminal open with a shell inside the
container:

```bash
docker-compose run web bash
```

To set up the database, you need change the hostname in
`app/apps/app_name/config/dev.exs`:

```elixir
41  hostname: "localhost",
```

to

```elixir
    hostname: "db"
```

Then you can ecto commands to initialize the database, you need to invoke them
inside the container:

```bash
cd app/apps/app_name
mix ecto.create
mix ecto.migrate
```
