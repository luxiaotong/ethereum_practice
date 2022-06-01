// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Counter {
    uint public count;
    function inc() external {
        count ++;
    }
    function dec() external {
        count --;
    }
}