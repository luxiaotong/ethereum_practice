
// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// safe math
// custom errors
// function outside contract
// import {symbol1 as alias, symbol2} from "filename"
// salted contract creations / create 2

contract SafeMath {
    function testUnderflow() public pure returns (uint) {
        uint x = 0;
        x--;
        return x;
    }
    function testUncheckedUnderflow() public pure returns (uint) {
        uint x = 0;
        unchecked{x--;}
        return x;
    }
}

error Unauthorized(address caller);

contract VendingMachine {
    address payable owner = payable(msg.sender);
    
    function withdraw() public {
        if (msg.sender != owner)
            // 23642 gas
            // revert("error");
            // 23692 gas
            // revert("error error error error error error error error error error error error");
            // 23388 gas
            // revert Unauthorized();
            revert Unauthorized(msg.sender);
        owner.transfer(address(this).balance);
    }
}

contract D {
    uint public x;
    constructor(uint a) {
        x = a;
    }
}

contract Create2 {
    function getBytes32(uint salt) external pure returns (bytes32) {
        return bytes32(salt);
    }
    function getAddress(bytes32 salt, uint arg) external view returns (address) {
        address addr = address(uint160(uint(
            keccak256(abi.encodePacked(
                bytes1(0xff),
                address(this),
                salt,
                keccak256(abi.encodePacked(
                    type(D).creationCode,
                    arg
                ))
            ))
        )));
        return addr;
    }
    
    address public deployedAddr;

    function createDSalted(bytes32 salt, uint arg) public {
        D d = new D{salt:salt}(arg);
        deployedAddr = address(d);
    }
}