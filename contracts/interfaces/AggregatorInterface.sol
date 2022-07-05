// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.10;

/**
  * @title AggregatorInterface
  * @author ESOLLABS
  * @notice Get price by lastest round or roundId, Get timestamp update price 
  * - 
  * - 
  * - 
 **/
interface AggregatorInterface {
  /**
    * @notice Get lastest price of asset.
  **/
  function latestAnswer() external view returns (int256);

  /**
    * @notice Get lastest updated time of asset.
  **/
  function latestTimestamp() external view returns (uint256);

  /**
    * @notice Get lastest round of asset.
  **/
  function latestRound() external view returns (uint80);

  /**
    * @notice Get price by roundId of asset.
    * @param roundId Round id of asset.
  **/
  function getAnswer(uint80 roundId) external view returns (int256);

  /**
    * @notice Get updated time by roundId of asset.
    * @param roundId Round id of asset.
  **/
  function getTimestamp(uint80 roundId) external view returns (uint256);

  /**
    * @notice Get decimals of asset.
  **/
  function decimals() external view returns (uint8);

  /**
    * @notice Get description of asset.
  **/
  function description() external view returns (string memory);

  /**
    * @notice Get version current of asset.
  **/
  function version() external view returns (uint256);

  /**
    * @notice Get data by round of asset.
    * @param roundId Round id of asset.
  **/
  function getRoundData(uint80 _roundId)
    external
    view
    returns 
  (
    uint80 roundId,
    int256 answer,
    uint256 startedAt,
    uint256 updatedAt,
    uint80 answeredInRound
  );

  /**
    * @notice Get data by lastest round of asset.
  **/
  function latestRoundData()
    external
    view
    returns 
  (
    uint80 roundId,
    int256 answer,
    uint256 startedAt,
    uint256 updatedAt,
    uint80 answeredInRound
  );

  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 updatedAt);

  event NewRound(uint256 indexed roundId, address indexed startedBy, uint256 startedAt);
}
