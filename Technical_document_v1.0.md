# SEER ORACLE
Copyright of ESOLLABS

## 1. Architecture:
 **[SEER v1.0](https://oracle-stag.vebank.io/home)** was built with concepts of multi-datasource and multi-processing-node.

<img alt="Vebank" align="center" src="https://github.com/phamanhtai0410/test_readme/blob/main/static/assets/SeerOracleDiagram.jpg?raw=true" width="100%" height="75%" >
<br></br>

-   Prices from multi data sources will be crawled by the crawler nodes. After that, data will be stored in database using Redis CLuster with Masters-Slaves Model.
- With the database, multi calculating nodes will be used to calculate final prices represented for each node. These processes will be implemented at the same time. 
- Prices from Calculating Nodes will be updated and be chosen by Seer Oracle SMC.
- When a SMC wants to use the prices, that one must have to make requests to Seer Oracle deployed in VeChain.

## 2. Core Components:
**Seer** contains 4 main components:
- [Crawler Nodes](https://github.com/seer-oracle/crawler-api.git): used for crawling data from different data sources of trusted exchanges.
- [Calculating Nodes](https://github.com/seer-oracle/calculate-node-job): used for beautifying data from the database and updating to Oracle SMC.
- [Oracle Smart Contract](https://github.com/seer-oracle/smc-price-oracle.git): included smart contracts that stored realtime prices for each asset and interfaces for others contracts to call to.
- [Oracle Website](https://github.com/seer-oracle/vb-oracle-website): UI for data feeds viewing.
- [API for Oracle Website](https://github.com/seer-oracle/vb-oracle-api):
Restful API for oracle website to call and get datas.

## 3. Formulas of Calculating Nodes:

- ### Algorithm using in calculating nodes:

    In general, the main concept is using Exponential Moving Average(EMA) to reduce the suddenly loss of price and maintain the stability of price feed in oracle.

- ### In details:
    - After crawling data to Database, we got a list of Multi-source datas of prices.
    -  Calculating Node will implement a function to choose "final_price" at that moment like: median, median_low, median_high,... This function can be controlled by the oracle owner.
    - Main algorithm: using Exponential Moving Average(EMA) to calculate price through time flow.
        - Initial values:
            * Interval Period: SLIDING_WINDOW_INTERVAL = 5 (means each 5 seconds algorithm will be          implemented one time)
            * Freshness Period: FRESHNESS_PERIOD = 3600 (means each 1 hour, histories data using for            algorithm will be reset)
        - Flow chart:
<img alt="Vebank" align="center" src="https://github.com/phamanhtai0410/test_readme/blob/main/static/assets/CalculatingNodeDiagram.png?raw=true" width="100%" height="75%" >