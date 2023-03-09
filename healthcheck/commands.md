docker container run --name p1 -d postgres:9.6.1

docker container run --name p2 -d --health-cmd="pg_isready -U postgres:9.6.1 || exit 1" postgres

---

docker service create --name p1 postgres:9.6.1

docker service create --name p2 --health-cmd="pg_isready -U postgres:9.6.1 || exit 1" postgres

---

# Healthcheck Docker Run Example

docker run \
  --health-cmd="curl -f localhost:9200/_cluster/health || false" \
  --health-interval=5s \
  --health-retries=3 \
  --health-timeout=2s \
  --health-start-period=15s \
  elasticsearch:2

# Healthcheck Dockerfile Examples

Options for healthcheck command
  --interval=DURATION (default: 30s)
  --timeout=DURATION (default: 30s)
  --start-period=DURATION (default: 0s)
  --retries=N (default: 3)

# Basic command using default options

HEALTHCHECK curl -f http://localhost/ || false

# Custom options with the command

HEALTHCHECK --timeout=2s --interval=3s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Healthcheck in Nginx Dockerfile

FROM nginx:1.13

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

# Healthcheck in PHP Nginx Dockerfile

FROM your-nginx-php-fpm-combo-image

HEALTHCHECK --interval=5s --timeout=3s \
  CMD curl -f http://localhost/ping || exit 1

# Healthcheck in postgres Dockerfile

FROM postgres

#specify real user with -U to prevent errors in log

HEALTHCHECK --interval=5s --timeout=3s \
  CMD pg_isready -U postgres || exit 1

# Healthcheck in Compose/Stack Files

version: "2.1" (minimum for healthchecks)
services:
  web:
    image: nginx
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 1m30s
      timeout: 10s
      retries: 3
      start_period: 1m #version 3.4 minimum
