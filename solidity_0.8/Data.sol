// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Data types - values & references

contract ValueTypes {
    bool public b = true;
    uint public u = 123; // uint = uint256
    int public i = -123; // int = int256
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}