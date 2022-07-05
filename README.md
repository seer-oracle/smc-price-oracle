# Smart Contract Seer Oracle

--- 
# Require
- Nodejs version: ^16.14.0, Npm version: ^8.5.0
- Install `npx`.
---
---
# Config network Ganache
- Install and config Ganache(ex: host='127.0.0.1', port: 7545)
- Change field 'from' in network ganache && ganache2 (ganache: owner, ganache2: user) in file truffle-config.js
---
---
# Config network Vechain Testnet
- Install  [web3-gear](https://github.com/vechain/web3-gear) .
- Export file keystore from  [Sync](https://env.vechain.org/) wallet.
- Run RPC `web3-gear --log 1 --debug 1 --host {HOST} --port {PORT} --endpoint https://sync-testnet.vechain.org --keystore {PATH_FILE_KEY_STORE}  --passcode {PASSWORD}`
---

---
# Deploy & Update price
- Install packages `npm install`  .
- Deploy SMC SeerOracle, DelegateSeer && Grant Role `npx truffle migrate --network {network} -f 2 --to 2` .
- After run step 2, coppy environment variables from file address.txt to file .env.
- Call update price from contract SeerOracle `npx truffle migrate --network {network} -f 3 --to 3` .
- Call update prices from contract DelegateSeer `npx truffle migrate --network {network} -f 4 --to 4` .
