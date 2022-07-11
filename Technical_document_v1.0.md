# SEER ORACLE
Copyright of ESOLLABS

## 1. Architecture:
 **[SEER v1.0](https://oracle-stag.vebank.io/home)** was built with concepts of multi-datasource and multi-processing-node.

<img alt="Vebank" align="center" src="https://github.com/phamanhtai0410/test_readme/blob/main/static/assets/SeerOracleDiagram.jpg?raw=true" width="100%" height="75%" >
<br></br>

- Prices from multiple data sources will be crawled by the crawler nodes. After that, data will be stored in database using Redis Cluster with Masters-Slaves Model.
- Then, multiple calculating nodes will be used to calculate final prices represented for each node. These processes will be executed at the same time.
- Prices from Calculating Nodes will be updated to blockchain.
- When a dApp wants to use the asset price, that one have to make the request to Seer Oracle deployed in VeChain.

## 2. Core Components:
**Seer oracle** contains 5 main components:
- [Crawler Nodes](https://github.com/seer-oracle/crawler-api.git): used for crawling data from different data sources of trusted exchanges.
- [Calculating Nodes](https://github.com/seer-oracle/calculate-node-job): used for aggregating data from the database and updating to oracle smart contracts.
- [Oracle Smart Contracts](https://github.com/seer-oracle/smc-price-oracle.git): included smart contracts that stored realtime prices for each asset and interfaces for others contracts to call to.
- [Oracle Website](https://github.com/seer-oracle/vb-oracle-website): Frontend for data feeds viewing.
- [API for Oracle Website](https://github.com/seer-oracle/vb-oracle-api):
Restful APIs for oracle website.

## 3. Formulas of Calculating Nodes:

- ### Algorithm using in calculating nodes:

    In general, the main concept is using Exponential Moving Average(EMA) to reduce the sudden loss of price and maintain the stability of price feed in oracle.

- ### In details:
    - After crawling data to database, we got a list of multi-source data of prices.
    -  Calculating Node will implement a function to choose "final_price" at that moment like: median, median_low, median_high,...
    - Main algorithm: using Exponential Moving Average(EMA) to calculate price through time flow.
        - Initial values:
            * Interval Period: SLIDING_WINDOW_INTERVAL = 5 (means each 5 seconds algorithm will be          executed one time)
            * Freshness Period: FRESHNESS_PERIOD = 3600 (means each 1 hour, histories data using for            algorithm will be reset)
        - Flow chart:
<img alt="Vebank" align="center" src="https://github.com/phamanhtai0410/test_readme/blob/main/static/assets/CalculatingNodeDiagram.png?raw=true" width="100%" height="75%" >