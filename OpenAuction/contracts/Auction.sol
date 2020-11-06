// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.4;

contract Auction {
    address payable public beneficiary;
    uint public deadline;
    bool public ended;
    uint public highestBid;
    address public highestBidder;
    mapping(address => uint) public refundPool;
    

    event HighestBidIncreased(address _bidder, uint _bid);
    event AuctionEnded(address _bidder, uint _bid);

    constructor(address payable _beneficiary, uint _after) {
        beneficiary = _beneficiary;
        deadline = block.timestamp + _after;
    }

    function bid() payable public {
        require(block.timestamp<deadline, "auction has ended");
        require(msg.value > highestBid, "need a higher bid");
        if (highestBid>0) {
            refundPool[highestBidder] += highestBid;
        }
        highestBid = msg.value;
        highestBidder = msg.sender;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    function withdraw() public returns(bool) {
        uint fund = refundPool[msg.sender];
        require(fund > 0, "nothing to refund");
        refundPool[msg.sender] = 0;
        if (!msg.sender.send(fund)) {
            refundPool[msg.sender] = fund;
            return false;
        }
        return true;
    }

    function end() public {
        require(block.timestamp>deadline, "auction has not ended yet");
        require(!ended, "auction has been ended");
        ended = true;
        emit AuctionEnded(highestBidder, highestBid);
        beneficiary.transfer(highestBid);
    }
}
