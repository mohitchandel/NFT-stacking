async function main() {
    // Deploying WarWeapon NFT 
    const WarWeapon = await ethers.getContractFactory("WarWeapon");
    const weapons = await WarWeapon.deploy();
    await weapons.deployed();

    // Deploying warcoin ERC20 token
    const Warcoin = await ethers.getContractFactory("Warcoin");
    const warcoin = await Warcoin.deploy();
    await warcoin.deployed();

    // Deploying Staking smart contract
    const Staking = await ethers.getContractFactory("Staking");
    const staking = await Staking.deploy(weapons.address, warcoin.address);
    await staking.deployed();

    console.log("WarWeapon deployed to:", weapons.address);
    console.log("Warcoin deployed to:", warcoin.address);
    console.log("Staking contract deployed to:", staking.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });