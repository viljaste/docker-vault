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

## License

**MIT**
