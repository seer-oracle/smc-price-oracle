// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.10;

/**
  * @title IDelegateSeer
  * @author ESOLLABS
  * @notice Set price for each asset.
 **/
interface IDelegateSeer {
    /**
        * @notice Mapping address asset to contract SeerOracle.
        * @param assets Assets address list.
    **/
    function setAssets(address[] memory assets) external;

    /**
        * @notice Update price for assets.
        * @param assets Assets address list.
        * @param prices List of prices corresponding to the assets address.
    **/
    function setAssetsPrice(address[] memory assets, int256[] memory prices) external;

    /**
        * @notice Update price for assets.
        * @param prices List of prices corresponding to the assets address.
    **/
    function updatePrices(uint256 prices) external;

    /**
        * @notice Update number assets.
        * @param _number Number asset.
    **/
    function setNumberAsset(uint8 _number) external;  

    function setCalculatePrice(address _addrCalculate) external;     
}