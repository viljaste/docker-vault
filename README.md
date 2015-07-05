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

## License

**MIT**
