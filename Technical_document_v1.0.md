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

        + SeerOracleVETUSDT: 0xa6cF09E6cC15cCBC0b7Fb8e0287710fDdfDBB7f6

        + SeerOracleVETBUSD: 0x59Bb2E6E9C8bDb2F1d701d29827c1C7b44F0A8Aa

        + SeerOracleVETHOUSD: 0x5E7A52743575FE6F8cD8937C0415640338eBdd29

        + SeerOracleVETHOUSDT: 0xb448016Ee01Db3b219963997FD5E08026A07e60c

        + SeerOracleVBUSD: 0xDf925feC9932A1De0d2b4404cCfac09166624F94

        + SeerOracleVBUSDT: 0xa366913D8E8FdcE13c58d5F20DF8C27f77BFF8AE

        + SeerOracleVBBUSD: 0xB92b92da7122937436cAa2bbd9B22c837cB1023C

        + SeerOracleVEUSDUSD: 0xA2B0d7b38dc13a58A7B4c0E8E2400d650dad46EC

        + SeerOracleVEUSDUSDT: 0xFDcC10429fA96bfD0E5FF7b76c7Da6156933BBB3

        + SeerOracleVEUSDBUSD: 0x4762F8647a763fB7599AdDf792E80897855b3294

        + SeerOracleBTCUSD: 0x18A2fEAae2fA06B3452fd094Ba802C93FF0dA972

        + SeerOracleBTCBUSDT: 0x51160f0383913De0F31A848f0263F9b00AD09563

        + SeerOracleBTCBUSD: 0x3Dd64A69a5ED7E6058ed533a8B8Bdf0527652dA8

        + SeerOracleETHUSD: 0xed8e829cfEB0Cdd315C26c7df10e81B12a3abA95

        + SeerOracleETHUSDT: 0x6A90EbA99ec7006eFD9AB5cA645cE291BB32924c

        + SeerOracleETHBUSD: 0x5e6790995dd9F5A0f8D85EaCB101ac294D7323ae

        + SeerOracleUSDCUSD: 0x109272eF2326d57A591dF5FD9D828AcdC72A212E

        + SeerOracleUSDTUSD: 0xbC8c3831117aC9A7E144f25A892A5410941d2C90

        + SeerOracleUSDCUSDT: 0x18F4b159ba4eDd94fdccFb602590fc10FFD31eBC

        + SeerOracleUSDCBUSD: 0x76c40604d306B388EAF976daE129bBBE15be4e39

        + SeerOracleBUSDUSDT: 0x5a513838ad80670aE8e48A99416b4D0897763fcA

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
        + Another dapps can build a contract with functions that can call to Seer Oracle addresses and get the suitable price when in need.
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
            |08|VTHO/USDT|VTHOUSDT|
            |09|VET/USD|VETUSD|
            |10|VET/BUSD|VETBUSD|
            |11|VET/USDT|VETUSDT|
            |12|VEUSD/USD|VEUSDUSD|
            |13|VEUSD/BUSD|VEUSDBUSD|
            |14|VEUSD/USDT|VEUSDUSDT|
            |15|VB/USD|VBUSD|
            |16|VB/BUSD|VBBUSD|
            |17|VB/USDT|VBUSDT|
            |18|USDC/USDT|USDCUSDT|
            |19|USDC/USD|USDCUSD|
            |20|USDC/BUSD|USDCBUSD|
            |21|USDT/USD|USDTUSD|
            |22|BUSD/USDT|BUSDUSDT|
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
            |07|Tether|USDT|
            |08|Binance USD|BUSD|
            |09|USD Coin|USDC|
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
- Prices from Calculating Nodes will be updated and be chosen by Seer Oracle SMC.
- SEER oracle's calculating nodes are monitoring prices of assets off-chain. The deviation of the real-world price of an asset triggers all the calculating nodes to update when the volatility is "big" enough. The below table shows how to estimate what the "big" volatility is for each assets by using **_Deviation Threshold_**:

| **ID** | **Pair of symbol** | **Deviation Threshold** |
| --- | --- | --- |
|01|BTC/USD|1%|
|02|BTC/BUSD|1%|
|03|BTC/USDT|1%|
|04|ETH/USD|1%|
|05|ETH/BUSD|1%|
|06|ETH/USDT|1%|
|07|VTHO/USD|1%|
|08|VTHO/USDT|1%|
|09|VET/USD|1%|
|10|VET/BUSD|1%|
|11|VET/USDT|1%|
|12|VEUSD/USD|1%|
|13|VEUSD/BUSD|1%|
|14|VEUSD/USDT|1%|
|15|VB/USD|1%|
|16|VB/BUSD|1%|
|17|VB/USDT|1%|
|18|USDC/USDT|0.5%|
|19|USDC/USD|0.5%|
|20|USDC/BUSD|0.5%|
|21|USDT/USD|0.5%|
|22|BUSD/USDT|0.5%|
- When a SMC wants to use the prices, that one need to make requests to Seer Oracle already deployed in VeChain.

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