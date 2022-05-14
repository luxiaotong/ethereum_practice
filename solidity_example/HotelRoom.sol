// SPDX-License-Identifier: UNLICENSE

pragma solidity ^0.8.0;

contract HotelRoom {
    // Ether - pay smart contracts
    // MOdifiers
    // Visibility
    // Events
    // Enums

    enum Statuses {
        Vacant,
        Occupied
    }
    Statuses currentStatuses;

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
        currentStatuses = Statuses.Vacant;
    }

    event Occupy(address _occupant, uint256 _value);

    modifier onlyWhileVacant() {
        require(currentStatuses == Statuses.Vacant, "Currently Occupied");
        _;
    }

    modifier costs(uint256 _amount) {
        require(msg.value >= _amount, "Not enough ether to provided");
        _;
    }

    receive() external payable onlyWhileVacant costs(2 ether) {
        currentStatuses = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
}
