//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library CalculatePrice{
    function getprice() internal view returns(uint256) {
        // for this we need two things:
        // ABI (We have impoted from Chainlink github)
        // Address (0x8A753747A1Fa494EC906cE90E9f37563A8AF630e)
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // latest round data returns price in 8 decimal points, but we need to match it with msg.value i.e 18 decimal points.
        return uint256 (price * 1e10);


    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 priceInUsd = getprice();
        return (priceInUsd*ethAmount)/1e18;

    }
}