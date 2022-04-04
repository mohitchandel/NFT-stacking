const WarWeapon = artifacts.require("WarWeapon");

module.exports = function (deployer) {
  deployer.deploy(WarWeapon);
};
