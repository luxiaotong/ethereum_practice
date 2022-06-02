// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// Function modifier - reuse code before and / or after function
// Basic, inputs, sandwitch

contract FunctionModifier {
    bool public paused;
    uint public x;
    
    function setPause(bool _paused) external {
        paused = _paused;
    }

    modifier whenNotPaused {
        require(!paused, "paused");
        _;
    }

    function inc() external whenNotPaused {
        x ++;
    }

    function dec() external whenNotPaused {
        x --;
    }

    modifier cap(uint _x) {
        require(_x < 100, "x >= 100");
        _;
    }

    function incBy(uint _x) external whenNotPaused cap(_x) {
        x += _x;
    }

    modifier sandwitch {
        x += 10;
        _;
        x *= 2;
    }

    function foo() external sandwitch {
        x += 1;
    }    
}