// SPDX-License-Identifier: UNLICENSE

pragma solidity ^0.8.0;

contract VariableContract {
    // State Variables
    string public _string = "hello world!";
    bytes32 public _bytes32 = "hello world!";
    uint public _uint = 1;
    int public _int = 2;
    uint8 public _uint8 = 3;
    uint256 public _uint256 = 4;
    address public _addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    struct Person {
        uint id;
        string name;
    }
    struct MyStruct {
        uint _uint;
        string _string;
    }
    MyStruct public myStruct = MyStruct(1, "hello world!");

    // Local Variables
    function getValue() public pure returns(uint) {
        uint val = 1;
        return val;
    }    
    function setValue(uint) public {
        _uint ++;
    }

    // Array
    uint[] public uintArray = [1,2,3];
    string[] public stringArray = ["apple", "banana", "carrot"];
    string[] public values;
    uint[][] public array2D = [[1,2,3],[4,5,6]];
    function addValue(string memory _value) public {
        values.push(_value);
    }
    function valueCount() public view returns(uint) {
        return values.length;
    }
}