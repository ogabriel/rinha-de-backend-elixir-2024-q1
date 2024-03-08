FROM hexpm/elixir:1.16.1-erlang-26.2.3-alpine-3.19.1 AS build

WORKDIR /app

# Install hex + rebar
RUN MIX_HOME=/app mix do local.hex --force, local.rebar --force

RUN apk add --no-cache \
    build-base \
    git

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# build app
COPY . .
RUN mix do compile, release

FROM alpine:3.18.2 AS release

RUN apk add --update --no-cache \
  libgcc \
  libstdc++ \
  ncurses-libs \
  make \
  curl

WORKDIR /app

COPY docker-entrypoint.sh ./
COPY --from=build /app/_build/prod/rel/* ./

ENTRYPOINT ["/app/docker-entrypoint.sh"]
