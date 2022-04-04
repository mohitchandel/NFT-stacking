const Warcoin = artifacts.require("Warcoin");

module.exports = function (deployer) {
  deployer.deploy(Warcoin);
};
