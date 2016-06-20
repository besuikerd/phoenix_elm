FROM elixir

ARG uid

RUN apt-get update \
    && apt-get install -y curl inotify-tools postgresql-client \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && npm install -g elm

RUN useradd web -u ${uid}
RUN mkdir -p /home/web/app
RUN chown -R web:web /home/web

WORKDIR /home/web/app
USER web

RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force
