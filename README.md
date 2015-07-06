# docker-vault

A [Docker](https://docker.com/) image for [Vault](https://vaultproject.io/).

## Run the container

Using the `docker` command:

    CONTAINER="vaultdata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /vault \
      viljaste/data:latest

    CONTAINER="vault" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      --restart always \
      -p 8200:8200 \
      --volumes-from vaultdata \
      -e SERVER_NAME="localhost" \
      -e BACKEND="file" \
      --cap-add IPC_LOCK \
      -d \
      viljaste/vault:latest

Using the `docker-compose` command

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-vault.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker-compose up

## Build the image

    TMP="$(mktemp -d)" \
      && GIT_SSL_NO_VERIFY=true git clone https://git.beyondcloud.io/viljaste/docker-vault.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker build -t viljaste/vault:latest . \
      && cd -

## Initializing the vault

    vault init -tls-skip-verify -address https://example.org:8200

## Configuration

### Supported backends

#### File

    BACKEND=file
    
#### Consul

    BACKEND=consul
    
##### Configurable options

    BACKEND_CONSUL_PATH=
    BACKEND_CONSUL_ADDRESS=
    BACKEND_CONSUL_SCHEME=
    BACKEND_CONSUL_DATACENTER=
    BACKEND_CONSUL_TOKEN=

#### Zookeeper

    BACKEND=zookeeper    
    
##### Configurable options

    BACKEND_ZOOKEEPER_PATH=
    BACKEND_ZOOKEEPER_ADDRESS=
    
#### In-memory

    BACKEND=inmem

### Connecting to Consul backend by linking Vault with Consul container

    vault:
      image: viljaste/vault:latest
      hostname: vault
      restart: always
      ports:
        - "8200:8200"
      volumes_from:
        - vaultdata
      links:
        - consul
      environment:
        - SERVER_NAME=localhost
      cap_add:
        - IPC_LOCK
    vaultdata:
      image: viljaste/data:latest
      hostname: vaultdata
      volumes:
        - /vault
    consul:
      image: viljaste/consul:latest
      hostname: consul
      restart: always
      ports:
        - "8300:8300"
        - "8301:8301"
        - "8301:8301/udp"
        - "8302:8302"
        - "8302:8302/udp"
        - "8400:8400"
        - "8500:8500"
        - "8600:8600"
        - "8600:8600/udp"
      volumes_from:
        - consuldata
      links:
        - conntrack
      environment:
        - ADVERTISE_ADDR=10.0.0.1
        - RETRY_JOIN=10.0.0.2
    consuldata:
      image: viljaste/data:latest
      hostname: consuldata
      volumes:
        - /consul
    conntrack:
      image: viljaste/conntrack:latest
      hostname: conntrack
      command: -F
      net: "host"
      cap_add:
        - NET_ADMIN

## License

**MIT**
