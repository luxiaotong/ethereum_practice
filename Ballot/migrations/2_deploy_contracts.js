const Ballot = artifacts.require("Ballot");

module.exports = function (deployer) {
  deployer.deploy(Ballot, [web3.utils.utf8ToHex('John Doe'), web3.utils.utf8ToHex('Main Street'), web3.utils.utf8ToHex('New York')]);
};
