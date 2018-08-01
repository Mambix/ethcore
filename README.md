# Supported tags and respective `Dockerfile` links
* `latest` ([Dockerfile])

![Ethereum v1.8.13](https://img.shields.io/badge/ethereum-v1.8.13-green.svg)

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

Now run the container, publishing ports 3001 (for Bitcore) and 8333 (for bitcoind).

```
docker run -d --restart=always --name ethcore \
   -p 3001:3001 -p 8333:8333 \
   -v ethcore_data:/root/.ethereum \
   mambix/ethcore
```

If you want to run Bitcore on the Testnet, first you need to add a configuration file to the data volume indicating that. Locate the data volume mount location on the Docker host:

```
docker volume inspect bitcore_data | grep Mountpoint
```

Create a file named `bitcore-node.json` in that directory with the following contents:

```
{
  "datadir": "/root/.bitcore/data",
  "network": "testnet",
  "port": 3001,
  "services": [
    "bitcoind",
    "db",
    "address",
    "web",
    "insight-api",
    "insight-ui"
  ]
}
```

Now run the container, publishing ports 3001 (for Bitcore) and 18333 (for bitcoind on Testnet):

```
docker run -d --restart=always --name ethcore \
   -p 3001:3001 -p 18333:18333 \
   -v ethcore_data:/root/.ethereum \
   mambix/ethcore
```


[Dockerfile]: <https://github.com/mambix/ethcore/blob/master/Dockerfile>
[GitHub repo]: <https://github.com/ethereum/go-ethereum>
[Ethereum site]: <https://www.ethereum.org/>
