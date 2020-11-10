const Ballot = artifacts.require("Ballot");

contract("Ballot", accounts => {
    console.log("account: ", accounts[0]);
    it("test Ballot", async () => {
        let instance = await Ballot.deployed();

        // test constructor
        let choice = await instance.choices.call(0);
        let name = await web3.utils.hexToString(choice.name);
        console.log(name);

        // test right
        instance.right(accounts[1]);
        instance.right(accounts[2]);
        instance.right(accounts[3]);

        // test vote
        instance.vote(1)
        instance.vote(1, { "from": accounts[1] })
        instance.vote(1, { "from": accounts[2] })

        // test winner
        winner = await instance.winner()
        name = await web3.utils.hexToString(winner)
        console.log("winner is: ", name)
    });
})