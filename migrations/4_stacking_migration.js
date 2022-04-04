const Stacking = artifacts.require("Stacking");
const WarWeapon = artifacts.require("WarWeapon");
const Warcoin = artifacts.require("Warcoin");

module.exports = function (deployer) {
  deployer.deploy(Stacking, WarWeapon.address, Warcoin.address);
};
