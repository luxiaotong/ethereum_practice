// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Is Ether send to contract?
// Is msg.data is empty?
// N: fallback()
// Y: is receive() exist?
// Y: receive()
// N: fallback()

contract Fallback {
    event Log(string func, address sender, uint256 value, bytes data);

    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, "");
    }
}
