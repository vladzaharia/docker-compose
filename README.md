# docker-compose

Templates for reproducible docker-compose service deployments.

## Configuration

Most services are configured with a corresponding `docker-compose.env` file which contains all necessary environment variables to run the service. Multiple config files can be created as `docker-compose.$service.env`.

### Agebox

[Agebox](https://github.com/slok/agebox) is used to encrypt and decrypt all environment files. Public keys (RSA SSH, Ed25519 SSH or Age X25519) are stored in `_agebox/keys`. 

#### Git hooks

Git hooks are available to help with encrypting on commit as well as decrypting on checkout/merge. They can be installed by running `_agebox/git/setup_git_hooks.sh`.

#### Agebox binaries

The agebox binaries are found in `_agebox/lib` and can be downloaded by executing `_agebox/lib/download.sh`.

#### Helper script

A helper script is found at `_agebox/agebox.sh` which calls the correct binary for your platform/architecture, provides some helper scripts, and adds necessary arguments for public key discovery.

##### `_agebox/agebox.sh encrypt-all`

Encrypts all environment files, including new ones. 

##### `_agebox/agebox.sh reencrypt`

Re-encrypt axebox-tracked files in order to commit to Git.

##### `_agebox/agebox.sh decrypt-all`

Decrypts all environment files, run if you see `docker-compose.env.agebox` files.

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

| Subnet          | Network Name    | Description                    |
| --------------- | --------------- | ------------------------------ |
| `172.20.1.0/24` | `traefik`       | Traefik reverse proxy          |
| `172.20.5.0/24` | `authentik`     | Internal authentication system |

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
