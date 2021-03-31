# Supported tags and respective `Dockerfile` links
* `latest` ([Dockerfile])

![Ethereum v1.8.13](https://img.shields.io/badge/ethereum-v1.8.13-green.svg)
[![](https://images.microbadger.com/badges/image/mambix/ethcore.svg)](https://microbadger.com/images/mambix/ethcore "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/mambix/ethcore.svg)](https://microbadger.com/images/mambix/ethcore "Get your own version badge on microbadger.com")

## Ethcore
Infrastructure to build Ethereum and blockchain-based applications for the next generation of financial technology.

Links:
* [Ethereum site];
* [GitHub repo].

## Running the container

Create a volume where all data and blockchain data will be stored:

```
docker volume create --name ethcore_data
```

Now run the container, publishing ports 8545 (for RPC) and 30303 (for ethereum network).

```
docker run -d --restart=always --name ethcore \
   -p 8545:8545 -p 30303:30303 \
   -v ethcore_data:/root/.ethereum \
   mambix/ethcore
```

## Aditional parameters
You can add aditional command line geth parameters by specifying GETH_CMD_PARAMS enviroment variable.  

For example:
```
docker run -d --restart=always --name ethcore \
   -p 8545:8545 -p 30303:30303 \
   -v ethcore_data:/root/.ethereum \
   -e GETH_CMD_PARAMS="--http.addr 0.0.0.0 --cache 4096 --maxpeers 10" \
   mambix/ethcore
```

## Running goerli testnet
```
docker run -d --restart=always --name ethcore_goerli \
   -p 8546:8546 -p 30304:30304 \
   -v ethcore_goerli_data:/root/.ethereum/goerli \
   -e GETH_CMD_PARAMS="--goerli --port 30304 --http.addr 0.0.0.0 --http.port 8546 --cache 4096 --maxpeers 10" \
   mambix/ethcore
```

[Dockerfile]: <https://github.com/mambix/ethcore/blob/master/Dockerfile>
[GitHub repo]: <https://github.com/ethereum/go-ethereum>
[Ethereum site]: <https://www.ethereum.org/>
