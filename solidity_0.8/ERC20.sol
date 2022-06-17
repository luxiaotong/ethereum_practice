// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol

interface IERC20 {
    function totalSupply() external view returns(uint);

    function balanceOf(address account) external view returns(uint);

    function transfer(address recipient, uint amount) external returns(bool);

    function allowance(address owner, address spender)
        external
        view
        returns(uint);

    function approve(address spender, uint amount) external returns(bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns(bool);

    event Transfer(address indexed from, address indexed to, uint amount);
    event Approval(address indexed owner, address indexed spender, uint amount);
}

contract ERC20 is IERC20 {
    uint public _totalSupply; 
    mapping(address => uint) public _balanceOf;
    mapping(address => mapping(address => uint)) public _allowances;

    string public name = "Test";
    string public symbol = "TEST";
    uint8 public decimals = 18;

    function totalSupply() external view override returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balanceOf[account];
    }

    function transfer(address recipient, uint amount) external override returns(bool) {
        _balanceOf[msg.sender] -= amount;
        _balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint amount) external override returns(bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns(bool) {
        _allowances[sender][msg.sender] -= amount;
        _balanceOf[sender] -= amount;
        _balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) external {
        _balanceOf[msg.sender] += amount;
        _totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) external {
        _balanceOf[msg.sender] -= amount;
        _totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}