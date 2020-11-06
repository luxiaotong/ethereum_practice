const Auction = artifacts.require("Auction");

module.exports = function (deployer, network, accounts) {
  deployer.deploy(Auction, accounts[0], 5 * 60);
};