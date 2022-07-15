// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "./simpleStorageCode1.sol";

contract StorageFactory{

    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorage() public {
        SimpleStorage newSimpleStorage = new SimpleStorage();
        simpleStorageArray.push(newSimpleStorage);
    }

    function sfstore(uint256 _sfIndex, uint256 _sfFavNum) public{
        simpleStorageArray[_sfIndex].store(_sfFavNum);
    }
    function sfGet(uint256 _sfIndex) public view returns (uint256) {
        return simpleStorageArray[_sfIndex].retrieve();
    }

}