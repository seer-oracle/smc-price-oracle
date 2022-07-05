// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.10;

import './SeerOracle.sol';
import './CalculatePrice.sol';
import {Errors} from '../libraries/helpers/Errors.sol';
import {IDelegateSeer} from '../interfaces/IDelegateSeer.sol';

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
    * @title DelegateSeer
    * @author ESOLLABS
    * @notice Contract to set asset prices, manage price sources.
*/
contract DelegateSeer is 
  AccessControlUpgradeable,
  OwnableUpgradeable,
  IDelegateSeer
{
    uint8 numberAsset;
    bytes32 public constant SET_PRICE_ROLE = keccak256("SET_PRICE_ROLE");
    bytes32 public constant SET_ASSET_ROLE = keccak256("SET_ASSET_ROLE");
    
    // mapping address seer contract => SeerOracle
    mapping(address => SeerOracle) private assetsSources;
    // mapping index asset => address contract SeerOracle
    mapping(uint256 => address) public indexAdressAsset;

    // mapping address CalculatePrice contract => SeerOracle
    CalculatePrice private calculatePrice;

    /// init access roles
    function initialize() external initializer {
        __AccessControl_init();
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(SET_PRICE_ROLE, msg.sender);
        _setupRole(SET_ASSET_ROLE, msg.sender); 
    }
    
    /// @inheritdoc IDelegateSeer
    function setAssets(address[] memory _assets) 
        external override 
        onlyRole(SET_ASSET_ROLE) 
    {
        for (uint256 i = 0; i < _assets.length; i++) {
            assetsSources[_assets[i]] = SeerOracle(_assets[i]);
            indexAdressAsset[i] = _assets[i];
        }
    }
    
    /// @inheritdoc IDelegateSeer
    function setCalculatePrice(address _addrCalculate) 
        external  
        onlyRole(SET_ASSET_ROLE) 
    {
        calculatePrice = CalculatePrice(_addrCalculate);
    }

    /// @inheritdoc IDelegateSeer
    function setNumberAsset(uint8 _number) 
        external override 
        onlyRole(SET_ASSET_ROLE) 
    {
        require(_number > 0, Errors.NUMBER_MUST_BE_GREATER_THAN_ZERO);
        numberAsset = _number;
    }

    /// @inheritdoc IDelegateSeer
    function setAssetsPrice(address[] memory assets, int256[] memory prices) 
        external override
        onlyRole(SET_PRICE_ROLE) 
    {
        for (uint256 i = 0; i < assets.length; i++) {
            if(prices[i] == 0) {
                continue;
            }
            assetsSources[assets[i]].updateAnswer(prices[i]);

        }
    }

    /// @inheritdoc IDelegateSeer
    function updatePrices(uint256 _prices) 
        external override 
        onlyRole(SET_PRICE_ROLE) 
    {
        // define with BE, max is 4 asssets with 0: vetho , 1: vet, 2: vebank, 3:veusd
        uint256[] memory _results = calculatePrice.decode(_prices);
        for (uint8 i = 0; i < _results.length; i++) {
            if (int256(_results[i]) == 0){
                continue;
            }
            // [TODO] update price decimal by bitwase
            address _addrAsset = indexAdressAsset[i];
            if (i == 3) { // index VEUSD
                assetsSources[_addrAsset].updateAnswer(int256(_results[i] * 10**12));
            } else {
                assetsSources[_addrAsset].updateAnswer(int256(_results[i]) * 10**6);
            }
        } 
    }
}
