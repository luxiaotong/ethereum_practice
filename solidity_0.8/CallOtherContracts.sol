// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract CallTestContract {
    function setX(TestContract _test, uint _x) external {
        _test.setX(_x);
    }
    
    function getX(TestContract _test) external view returns(uint) {
        return _test.getX();
    }

    function sendXandSendEther(address _test, uint _x) external payable {
        TestContract(_test).setXandSendEther{value: msg.value}(_x);
    }
    
    function getXandValue(address _test) external view returns(uint x, uint value) {
        (x, value) = TestContract(_test).getXandValue();
    }
}

contract TestContract {
    uint public x;
    uint public value;

    function setX(uint _x) public returns (uint) {
        x = _x;
        return x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandSendEther(uint _x) public payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }
}