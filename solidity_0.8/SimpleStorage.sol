// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract SimpleStorage {
    string public text;

    // aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    // calldata 89686 gas
    // memory 90174 gas
    function set(string calldata _text) external {
        text = _text;
    }

    function get() external view returns(string memory) {
        return text;
    }
}