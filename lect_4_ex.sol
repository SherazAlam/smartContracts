pragma solidity ^0.7.5;

contract exercise{
    address deployer;
    constructor(){
        deployer = msg.sender;
    }
    function test() public view returns(address){
        if (msg.sender == deployer){
            return msg.sender;
        }
    }
}