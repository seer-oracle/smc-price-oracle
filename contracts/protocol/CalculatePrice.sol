// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.10;

/**
 * @title CalculatePrice Contract
 * @author ESOLLABS
 * @notice Contract decode/endcode price of asset
 */
contract CalculatePrice {
    uint256[] public pricesBit;

    function setPriceBit(uint256[] memory _pricesBit) external {
        for (uint256 i = 0; i < _pricesBit.length; i++) {
            pricesBit.push(_pricesBit[i]);
        }
    }

    function decode(uint256 _encodedValue) external view returns(uint256[] memory) {
        uint256 _total_bit;
        uint256[] memory _decoded_vals = new uint256[](pricesBit.length) ;
        for (uint256 i = 0; i < pricesBit.length; i++) {
            uint256 _decoded_val = (_encodedValue >> _total_bit) & ((1 << pricesBit[i]) - 1);
            _decoded_vals[i] = _decoded_val;
            _total_bit += pricesBit[i];
        }
        return _decoded_vals;
    }
}