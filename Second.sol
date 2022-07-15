pragma solidity ^0.8.13;

contract counter{
    int public num;
    function add () public{
        num = num + 1;
    }
    function sub () public{
        num = num - 1;
    }
}