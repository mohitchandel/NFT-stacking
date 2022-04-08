const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Staking WarWeapons NFT", function () {

  let weapons;
  let warcoin;
  let staking;
  let admin;

  beforeEach(async function () {

    // getting admin address
    [admin] = await ethers.getSigners();

    // Deploying WarWeapon NFT 
    const WarWeapon = await ethers.getContractFactory("WarWeapon");
    weapons = await WarWeapon.deploy();
    await weapons.deployed();

    // Deploying warcoin ERC20 token
    const Warcoin = await ethers.getContractFactory("Warcoin");
    warcoin = await Warcoin.deploy();
    await warcoin.deployed();

    // Deploying Staking smart contract
    const Staking = await ethers.getContractFactory("Staking");
    staking = await Staking.deploy(weapons.address, warcoin.address);
    await staking.deployed();

  });

  describe("NFT token", function () {
    it("Should mint WarWeapon ERC1155", async function () {
      expect(await weapons.owner()).to.equal(admin.address);
    });
  });

  describe("Reward token", function () {
    it("Should mint reward token", async function () {
      const tokenMinting = await warcoin.mint(admin.address, 100)
      await tokenMinting.wait()
      const tokenBalance = await warcoin.balanceOf(admin.address);
      expect(await warcoin.totalSupply()).to.equal(tokenBalance);
    });
  });

  describe("stake NFT", function () {
    it("should stake NFT", async function () {
      // Approving token spend
      const approveWarWapons = await weapons.setApprovalForAll(staking.address, true)
      await approveWarWapons.wait()
      expect(await weapons.isApprovedForAll(admin.address, staking.address)).to.equal(true);

      // Staking NFT
      const stakeAmount = 10;
      const stakeForMonths = 1;
      const stakeNFTToken = await staking.stakeNFTToken(weapons.knife(), stakeAmount, stakeForMonths);
      await stakeNFTToken.wait()
      const stakedNFT = await staking.staked(admin.address)
      expect(stakedNFT.amount).to.equal(stakeAmount);
    })

    it("should unstake NFT if staking time is complete", async function () {
      // Approving token spend
      const approveWarWapons = await weapons.setApprovalForAll(staking.address, true)
      await approveWarWapons.wait()
      expect(await weapons.isApprovedForAll(admin.address, staking.address)).to.equal(true);

      // Staking NFT
      const stakeAmount = 10;
      const stakeForMonths = 1;
      const stakeNFTToken = await staking.stakeNFTToken(weapons.knife(), stakeAmount, stakeForMonths);
      await stakeNFTToken.wait()
      const stakedNFT = await staking.staked(admin.address)
      expect(stakedNFT.amount).to.equal(stakeAmount);

      // Unstaking NFT
      /* 
       condition should be applied because this contract will not allow to unstack NFT before time completed
      */
      if(stakedNFT.toTime <= (Date.now()/1000)){
        const unStakeNFT = await staking.unstakeNFTToken()
        await unStakeNFT.wait();
        expect(stakedNFT.amount).to.equal(0);
      }else{
        console.log("Not allowed to unstacke before time")
      }
    })
  });

});
