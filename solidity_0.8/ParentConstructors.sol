// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract S {
    string public name;
    
    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;
    
    constructor(string memory _text) {
        text = _text;
    }
}

// 1st way
contract U is S("s"), T("t") {

}

// 2nd way
contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {
    }
}

contract VV is S("s"), T {
    constructor(string memory _text) T(_text) {
    }
}


// Order of execution
// S -> T -> V0
contract V0 is S, T {
    constructor(string memory _name, string memory _text) T(_name) S(_text) {
    }
}

// Order of execution
// S -> T -> V1
contract V1 is S, T {
    constructor(string memory _name, string memory _text) T(_text) S(_name) {
    }
}

// Order of execution
// T -> S -> V2
contract V2 is S, T {
    constructor(string memory _name, string memory _text) T(_text) S(_name) {
    }
}

// Order of execution
// T -> S -> V3
contract V3 is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {
    }
}