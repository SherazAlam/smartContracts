// Get Funds from users
//Withdraw Funds
//We can set mininum funding in USD
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CalculatePrice.sol";

error NotOwner();

contract FundMe{
    using CalculatePrice for uint256;
    uint public constant LEASTAMOUNT = 50 * 1e18;
    address[] public funders;
    address public immutable i_owner;
    mapping (address => uint256) public addressToFundedAmount;
    
    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        //without library
        //require(getConversionRate(msg.value) >= LEASTAMOUNT, "Didn't pay enough"); //Require Function: If condition didn't met, it reverts means stop further execution of code in the called function and thus save further spent of gas fee. It also undone all the done work in a function.
        require(msg.value.getConversionRate() >= LEASTAMOUNT, "Didn't pay enough");
        funders.push(msg.sender);
        addressToFundedAmount[msg.sender] += msg.value;
    }

    


    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToFundedAmount[funder] = 0;
        }
        funders = new address[](0);

        //Three ways to with draw
        // transfer
        //payable(msg.sender).transfer(address(this).balance);
        // send
        //bool sendSucceed = payable(msg.sender).send(address(this).balance);
        //require(sendSucceed, "Send failed!");
        // call
        (bool callSucceed,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucceed, "Call failed!");
    }
    modifier onlyOwner{
        //require(msg.sender == i_owner, "Only owner can call this");
        // In require function, string: "Only owner can call this" is taking more gas so
        if (msg.sender != i_owner) { revert NotOwner();}
        
        _;
    }
    receive() external payable {
        fund();
    }
    fallback() external payable {
        fund();
    }
}