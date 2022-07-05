// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.10;

/**
  * @title ISeerOracle
  * @author ESOLLABS
  * @notice Update price for asset, update round data of asset.
 **/
interface ISeerOracle {
    /**
        * @notice Update price for asset.
        * @param _price Price update for asset.
    **/
    function updateAnswer(int256 _price) external;

    /**
        * @notice Get lastest price of asset.
    **/
    function getAssetPrice()  external view returns(int256);

    /**
        * @notice Update round data for asset.
        * @param _roundId Round update for asset.
        * @param _answer Price update for asset.
        * @param _timestamp Timestamp update.
        * @param _startedAt Start time round.
    **/
    function updateRoundData(
    uint80 _roundId,
    int256 _answer,
    uint256 _timestamp,
    uint256 _startedAt
  ) external;
}