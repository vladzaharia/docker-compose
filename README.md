# docker-compose

Templates for reproducible docker-compose service deployments.

## Configuration

Most services are configured with a corresponding `docker-compose.env.yml` file which contains all necessary environment variables to run the service.

## Volumes

All services should save their configuration and data whenever possible.

Most services will run with hostpath volume binding on a folder in `/data`. Some services have strict permission requirements and run as specific users, in which case a Docker volume is used.

## Service Dependencies

Each service will run its own set of dependencies (Postgres, Maria, Mongo, Redis, etc.) which can be managed using internal administration tools.

## Reverse Proxies

Traefik is used for internal and external reverse proxying, both HTTP and TCP. All requests should use TLS. External services can be proxied on `zhr.one`, `vlad.gg` or `polaris.video` root domains while internal services should be exposed on `int.zhr.one`.

## Networks

Services which run without any dependencies can run on the default Docker network. If the service requires or is used by another service, then a custom network is created:

### `172.20.0.0/16` - Infrastructure

| Subnet          | Network Name    | Description            |
| --------------- | --------------- | ---------------------- |
| `172.20.1.0/24` | `traefik`       | Traefik reverse proxy  |

### `172.25.0.0/16` - Database Management

| Subnet          | Network Name    | Description            |
| --------------- | --------------- | ---------------------- |
| `172.25.1.0/24` | `pgadmin`       | Postgres DB Management |
| `172.25.2.0/24` | `pgadmin`       | Postgres DB Management |
| `172.25.5.0/24` | `mongo-express` | Mongo Management       |


### `172.30.0.0/16` - Media Services

| Subnet           | Network Name    | Description                    |
| ---------------- | --------------- | ------------------------------ |
| `172.30.1.0/24`  | `prowlarr`      | Access to indexer for indexers |
| `172.30.2.0/24`  | `sonarr`        | Access to indexer for TV shows |
| `172.30.3.0/24`  | `radarr`        | Access to indexer for movies   |
| `172.30.5.0/24`  | `plex`          | Access to indexer for Plex     |
| `172.30.10.0/24` | `sabnzbd`       | Access to NZB downloader       |
| `172.30.11.0/24` | `qbittorrent`   | Access to Torrent downloader   |
