// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// require/revert/assert
// - gas refund, state updates are reverted
//  custom error - save gas
contract Error {
    function testRequire(uint _i) public pure {
        // 22011 gas
        require(_i <= 10, "i > 10");
    }

    function testRevert(uint _i) public pure {
        if(_i > 10) {
            revert("i > 10");
        }
    }

    uint public num = 123;

    function testAssert() public view {
        assert(num == 123);
    }

    function foo(uint _i) public {
        num +=1;
        require(_i < 10);
    }
    
    error MyError(address caller, uint i);
    
    function testCustomError(uint _i) public view {
        if (_i > 10) {
            // 21901 gas
            revert MyError(msg.sender, _i);
        }
    }
}