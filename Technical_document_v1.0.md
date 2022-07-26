# SEER ORACLE
Copyright of ESOLLABS

## 1. How to use Seer Oracle ?

- ### On-chain:
    * Get data from SEER oracle using Inspector app from VeChain:
	    + <video src="https://user-images.githubusercontent.com/42676851/180912366-3714c496-8928-4135-9180-7ec37a01381a.mp4"  controls="controls" style="width: 730px;">
            </video>
        + _Reference_: **[VeChain Inpsector App](https://inspector.vecha.in/)**

    * Dapps can access prices through Seer Oracle smart contracts - listed below:
        + SeerOracleVETUSD: 0x3212feD5581DEFbb2d7Ea21d7F22f657cD3da97E
        + SeerOracleVETHOUSD: 0x5E7A52743575FE6F8cD8937C0415640338eBdd29
        + SeerOracleVBUSD: 0xDf925feC9932A1De0d2b4404cCfac09166624F94
        + SeerOracleVEUSDUSD: 0xA2B0d7b38dc13a58A7B4c0E8E2400d650dad46EC
        + SeerOracleBTCUSD: 0x18A2fEAae2fA06B3452fd094Ba802C93FF0dA972
        + SeerOracleETHUSD: 0xed8e829cfEB0Cdd315C26c7df10e81B12a3abA95
    * **_How to get oracle data ?_**:
        + Call to specificed contract on demand.
        + Ex: want to have price of VET/USD currency pair => Call to contract: "SeerOracleVETUSD" with address "0x3212feD5581DEFbb2d7Ea21d7F22f657cD3da97E"
        + Contract functions need to be called:
            ```
            function latestAnswer()
                external view override
                returns (int256)
            {
                return assetDetail.price;
            }

            ```
        + Another dapps can build a contract to Seer Oracle addresses and call to suitable one when in need.
- ### Off-chain:
    We support solution to getting latest price via restful API as below:
    * Domain: https://api-stag.vebank.io/v1/oracle/
    * **_1. Get available assets list:_**
        +   Methods: [GET]
        +   Routing:
            ```
            /asset/now_available
            ```
        +   Example:
            ```
            curl --location --request GET 'https://api-stag.vebank.io/v1/oracle/asset/now_available'
            ```
    * **_2. Get latest price by symbol pair:_**
        +   Methods: [GET]
        +   Routing:
            ```
            /price/<symbol_pair>/latest
            ```
        +   Supported pair of symbols:
            | **ID** | **Pair Of Symbols** | **<symbol_pair>** |
            | --- | --- | --- |
            |01|BTC/USD|BTCUSD|
            |02|BTC/BUSD|BTCBUSD|
            |03|BTC/USDT|BTCUSDT|
            |04|ETH/USD|ETHUSD|
            |05|ETH/BUSD|ETHBUSD|
            |06|ETH/USDT|ETHUSDT|
            |07|VTHO/USD|VTHOUSD|
            |08|VTHO/BUSD|VTHOBUSD|
            |09|VTHO/USDT|VTHOUSDT|
            |10|VET/USD|VETUSD|
            |11|VET/BUSD|VETBUSD|
            |12|VET/USDT|VETUSDT|
            |13|VEUSD/USD|VEUSDUSD|
            |14|VEUSD/BUSD|VEUSDBUSD|
            |15|VEUSD/USDT|VEUSDUSDT|
            |16|VB/USD|VBUSD|
            |17|VB/BUSD|VBBUSD|
            |18|VB/USDT|VBUSDT|
        +   Example:
            ```
            curl --location --request GET 'https://api-stag.vebank.io/v1/oracle/price/BTCUSD/latest'
            ```
    * **_3. Get latest prices of a symbol:_**
        +   Methods: [GET]
        +   Routing:
            ```
            /price/symbol/<symbol>
            ```
        +   Supported symbols:
            | **ID** | **Token** | **<symbol>** |
            | --- | --- | --- |
            |01|Bitcoin|BTC|
            |02|Ethereum|ETH|
            |03|Vet|VET|
            |04|Vethor Token|VTHO|
            |05|VeUSD|VEUSD|
            |06|VeBank|VB|
        +   Example:
            ```
            curl --location --request GET 'https://api-stag.vebank.io/v1/oracle/price/symbol/BTC'
            ```
    * **_4. Get latest price feed:_**
        +   Methods: [GET]
        +   Routing:
            ```
            /price/oracle/latest
            ```
        +   Example:
            ```
            curl --location --request GET 'https://api-stag.vebank.io/v1/oracle/price/oracle/latest'
            ```
## 2. Architecture:
 **[SEER v1.0](https://oracle-stag.vebank.io/home)** was built with concepts of multi-datasource and multi-processing-node.

<img alt="Vebank" align="center" src="https://github.com/phamanhtai0410/test_readme/blob/main/static/assets/SeerOracleDiagram.jpg?raw=true" width="100%" height="75%" >
<br></br>

-   Prices from multi datasources will be crawled by the crawler nodes. After that, data will be stored in database using Redis CLuster with Masters-Slaves Model.
- With database, multi calculating nodes will be used to calculate final prices prepresented for each nodes. These processes will be implemented at the same time.
- Prices from Calculating Nodes will be update and be chosen by Seer Oracle SMC.
- When a SMC wants to use the prices, that one must have to make requests to Seer Oracle deployed in VeChain.

## 3. Core Components:
**Seer** contains 4 main components:
- [Crawler Nodes](https://github.com/seer-oracle/crawler-api.git): used for crawling data from different datasources of trusted exchanges.
- [Calculating Nodes](https://github.com/seer-oracle/calculate-node-job): used for beautifying data from database and updating to Oracle SMC.
- [Oracle Smart Contract](https://github.com/seer-oracle/smc-price-oracle.git): included smart contracts that stored realtime prices for each assets and interfaces for others contracts to call to.
- [Oracle Website](https://github.com/seer-oracle/vb-oracle-website): UI for data feeds viewing.
- [API for Oracle Website](https://github.com/seer-oracle/vb-oracle-api):
Restful API for oracle website to call and get datas.

## 4. Formulas of Calculating Nodes:

- ### Algorithm using in calculating nodes:

    In general, main concept is using Exponential Moving Average(EMA) to reduce the suddenly loss of price and maintain the stability of price feed in oracle.

- ### In details:
    - After crawling data to Database, we got a list of Multi-source datas of prices.
    -  Calculating Node will implement a function to choose "final_price" at that moment like: median, median_low, median_high,... This function can be controlled by oracle owner.
    - Main algorithm: using Exponential Moving Average(EMA) to calculate price through time flow.
        - Initial values:
		    * Interval Period: SLIDING_WINDOW_INTERVAL = 5 (means each 5 seconds algorithm will be 			implemented one time)
		    * Freshness Period: FRESHNESS_PERIOD = 3600 (means each 1 hour, histories data using for 			algorithm will be reset)
        - Flow chart:
<img alt="Vebank" align="center" src="https://github.com/phamanhtai0410/test_readme/blob/main/static/assets/CalculatingNodeDiagram.png?raw=true" width="100%" height="75%" >