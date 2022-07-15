//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract fallBack{

    uint256 public test;
    receive() external payable {
        test = 1;
    }
    fallback() external payable {
        test = 2;
    }
}