// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.5.16 <=0.7.4;

contract Ballot {
    struct Choice {
        bytes32 name;
        uint n;
    }
    struct Voter {
        uint cid;
        bool voted;
        uint weight;
        address delegate;
    }

    address public holder;
    mapping (address => Voter) public voters;
    Choice[] public choices;

    constructor(bytes32[] memory _choices) {
        holder = msg.sender;
        voters[holder].weight = 1;
        for(uint i = 0; i < _choices.length; i ++) {
            choices.push(Choice({
                name: _choices[i],
                n: 0
            }));
        }
    }

    function vote(uint _cid) public {
        Voter storage voter = voters[msg.sender];
        require(voter.voted == false, "Just vote once");
        require(voter.weight > 0, "No right to vote");
        voter.voted = true;
        voter.cid = _cid;
        choices[_cid].n += voter.weight;
    }

    function right(address _voter) public {
        require(msg.sender == holder, "only holder can update right");
        Voter storage voter = voters[_voter];
        require(voter.weight == 0, "has right to vote");
        voter.weight = 1;
    }

    function delegate(address _voter) public {
        require(_voter != msg.sender, "only delegate to others");

        Voter storage me = voters[msg.sender];
        require(me.voted == false, "have voted");

        while(voters[_voter].delegate != address(0)) {
            _voter = voters[_voter].delegate;
            require(_voter != msg.sender, "Found loop in delegation");
        }
        Voter storage voter = voters[_voter];

        me.voted = true;
        me.delegate = _voter;

        if (voter.voted) {
            choices[voter.cid].n += me.weight;
        } else {
            voter.weight += me.weight;
        }
    }

    function winner() public view returns(bytes32 name_) {
        uint max = 0;
        for(uint i = 0; i < choices.length; i ++) {
            if (choices[i].n > max) {
                name_ = choices[i].name;
                max = choices[i].n;
            }
        }
    }
}

// let accounts = await web3.eth.getAccounts()
// let instance = await Ballot.deployed()
// instance.vote(1)
// instance.vote(1, {"from":accounts[1]})
// instance.vote(1, {"from":accounts[2]})
// let n = await instance.getVote(1)
// n.toNumber()
// winner = await instance.winner()
// web3.utils.hexToString(winner)