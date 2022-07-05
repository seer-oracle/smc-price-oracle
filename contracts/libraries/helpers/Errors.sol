// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.10;

/**
 * @title Errors library
 * @author Seer Oracle
 * @notice Defines the error messages emitted by the different contracts of the Seer protocol
 */
library Errors {
  string public constant INVALID_ASSET_ID = '1'; // 'Invalid asset id'
  string public constant PRICE_MUST_BE_GREATER_THAN_ZERO = '2'; // 'Price of fuction setPrice price must be greater than 0'
  string public constant ASSET_ALREADY_EXISTS = '3'; // 'Asset already exists'
  string public constant NUMBER_MUST_BE_GREATER_THAN_ZERO = '4'; // 'Number must be greater than 0'
  string public constant INVALID_ANSWER_IN_ROUND = '5'; // 'Invalid answer in round'
}
