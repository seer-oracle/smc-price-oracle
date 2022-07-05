// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.10;

import {Errors} from '../libraries/helpers/Errors.sol';
import {AggregatorInterface} from '../interfaces/AggregatorInterface.sol';
import {ISeerOracle} from '../interfaces/ISeerOracle.sol';

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
  * @title SeerOracle
  * @author ESOLLABS
  * @notice Contract to set asset price, manage price source.
*/
contract SeerOracle is 
  AccessControlUpgradeable,
  OwnableUpgradeable,
  AggregatorInterface,
  ISeerOracle
  {  
  uint8 DECIMALS;
  uint80 public constant ROUND_DEFAULT = 1;
  uint VERSION;
  string DESCRIPTION;
  
  // mapping(LatestRound => answer)
  mapping(uint256 => int256) public GetAnswer;
  //mapping(LatestTimestamp => timestamp)
  mapping(uint256=>uint256) public GetTimestamp;
  //mapping(LatestTimestamp => timestamp)
  mapping(uint256=>uint256) private GetStartedAt;

  struct AssetsPrice {    
    int256 price;
    uint80 round;
    string symbol;
    uint256 updatedTime;
  }
  AssetsPrice assetDetail;

  // set up roles
  bytes32 public constant SET_PRICE_ROLE = keccak256("SET_PRICE_ROLE");
  bytes32 public constant GET_PRICE_ROLE = keccak256("GET_PRICE_ROLE");
  bytes32 public constant REGISTER_ASSET_ROLE = keccak256("REGISTER_ASSET_ROLE");
  bytes32 public constant UPDATE_ROUND_ROLE = keccak256("UPDATE_ROUND_ROLE");
  
  // events
  event UpdateAnswer(address _from, int256 _price, uint80 _round, uint256 _updateTime);
  event InitAsset(address _from, int256 _price, string _symbol, uint256 _updateTime);

  constructor (int256 _price, string memory _symbol, string memory _description, uint256 _version, uint8 _decimal) {
    uint256 timeNow = block.timestamp;
    // AssetsPrice memory assetDetail;
    assetDetail.price = _price;
    assetDetail.round = ROUND_DEFAULT;
    assetDetail.symbol = _symbol;
    assetDetail.updatedTime = timeNow;
    DESCRIPTION = _description;
    VERSION = _version;
    DECIMALS = _decimal;
    // update data by round
    GetAnswer[ROUND_DEFAULT] = _price;
    GetTimestamp[ROUND_DEFAULT] =  timeNow;
    GetStartedAt[ROUND_DEFAULT] = timeNow;
    emit InitAsset(msg.sender, _price, _symbol, timeNow);
  }

  /// init access roles
  function initialize() external initializer {
    __AccessControl_init();
    _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    _setupRole(GET_PRICE_ROLE, msg.sender);
    _setupRole(SET_PRICE_ROLE, msg.sender);
    _setupRole(UPDATE_ROUND_ROLE, msg.sender);
  }

  /// @inheritdoc ISeerOracle
  function updateAnswer(int256 _price) 
    external override 
    onlyRole(SET_PRICE_ROLE) 
  {
    require(_price > 0, Errors.PRICE_MUST_BE_GREATER_THAN_ZERO);
    uint256 timeNow = block.timestamp;
    assetDetail.price = _price;
    assetDetail.round ++;
    assetDetail.updatedTime = timeNow;
    // update data by round
    GetAnswer[assetDetail.round] = _price;
    GetTimestamp[assetDetail.round] = timeNow;
    GetStartedAt[assetDetail.round] = timeNow;
    emit UpdateAnswer(msg.sender, _price, assetDetail.round, timeNow);
  }

  /// @inheritdoc ISeerOracle
  function updateRoundData(
    uint80 _roundId,
    int256 _answer,
    uint256 _timestamp,
    uint256 _startedAt
  ) external 
    override 
    onlyRole(UPDATE_ROUND_ROLE) 
  {
    require(GetAnswer[_roundId] > 0, Errors.INVALID_ANSWER_IN_ROUND);
    GetAnswer[_roundId] = _answer;
    GetTimestamp[_roundId] = _timestamp;
    GetStartedAt[_roundId] = _startedAt;
  }

  /// @inheritdoc ISeerOracle
  function getAssetPrice() 
    external view override
    returns(int256) 
  {
    return assetDetail.price;
  }

  /// @inheritdoc AggregatorInterface
  function latestAnswer() 
    external view override  
    returns (int256) 
  {
    return assetDetail.price;
  }

  /// @inheritdoc AggregatorInterface
  function latestTimestamp() 
    external view override 
    returns(uint256) 
  {
    return assetDetail.updatedTime;
  }


  /// @inheritdoc AggregatorInterface
  function getAnswer(uint80 _roundId) 
    external view override 
    returns(int256) 
  {
    return GetAnswer[_roundId];
  }

  /// @inheritdoc AggregatorInterface
  function getTimestamp(uint80 _roundId) 
    external view override 
    returns(uint256) 
  {
    return GetTimestamp[_roundId];
  }

  /// @inheritdoc AggregatorInterface
  function latestRound() 
    external view override 
    returns(uint80) 
  {
    return assetDetail.round;
  }
  
  /// @inheritdoc AggregatorInterface
  function decimals() 
    external view override 
    returns(uint8) 
  {
    return DECIMALS;
  }

  /// @inheritdoc AggregatorInterface
  function description() 
    external view override 
    returns(string memory) 
  {
    return DESCRIPTION;
  }

  /// @inheritdoc AggregatorInterface
  function version() 
    external view override 
    returns(uint256)
  {
    return VERSION;
  }

  /// @inheritdoc AggregatorInterface
  function getRoundData(uint80 _roundId)
    external
    view
    returns (uint80, int256, uint256, uint256, uint80)
  {
    return (
      _roundId,
      GetAnswer[_roundId],
      GetStartedAt[_roundId],
      GetTimestamp[_roundId],
      _roundId
    );
  }

  /// @inheritdoc AggregatorInterface
  function latestRoundData()
    external
    view
    override
    returns (uint80, int256, uint256, uint256, uint80)
  {
    return (
      assetDetail.round,
      assetDetail.price,
      GetStartedAt[assetDetail.round],
      assetDetail.updatedTime,
      assetDetail.round
    );
  }

}