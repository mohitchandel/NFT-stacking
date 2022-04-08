# NFT Stacking Smart Contract

Token is created and deployed on Rinkeby Test network

ERC1155 Standard Token (NFT) :point_right:	 [WarWeapons](https://rinkeby.etherscan.io/address/0x5aA22BeF1eF4BdB15Fcce13345AE4b19D787cb17)

ERC20 Standard Token (Reward Coin) :point_right:	 [Warcoin](https://rinkeby.etherscan.io/address/0xccd40ebD384eEE363F651B46952f94A1bcB9e6e1)

### Usage

Before running any command, make sure to install dependencies:

`npm install`

#### Compile

Compile the smart contracts with Hardhat: 

`npx hardhat compile`

#### Test

Run the tests:

`npx hardhat test`

#### Deploy

deploy contract to netowrk: 

`npx hardhat run --network rinkeby scripts/deploy.js`

## Stacking Smart Contract

stacking smart contract will be created after the creation of NFT (WarWeapons) and Reward token (warcoin) first because the Staking smart contract has two paremeters in its contructor to define the tokens.

`constructor(WarWeapon _nftaddress, Warcoin _rewardToken) {}`

functions need to call before stacking

`setApprovalForAll(address operator, approved true)` 


this function is used to assign or revoke the full approval rights to the given operator. The caller of the function (msg.sender) is the approver.

The function takes the following arguments:

- `operator`: This is the address of the operator to whom the approval rights should be given or revoked from the approver.
- `approved`: This is the Boolean representing the approval to be given or revoked.

after the approval function NFT is ready for staking ([staking contract](https://rinkeby.etherscan.io/address/0x18F55DA7Cb736691c93C4864C01C2e7Da69581c5#code))

### How to stake

In stacking smart contract function `stakeNFTToken(uint256 _tokenId, uint256 _amount, uint16 _months) ` is used to stake the NFT.

this function has following arguments:

- `uint256 _tokenID` : It is the token Id or NFT id which user want stake.
- `uint256 _amount` : Amount of NFT user want to stake.
- `uint16 _months` : For how many moths i.e. 1,6 or 12 (only these inputs are allowed).


### How to Unstake NFT

The `unstakeNFTToken()` function is used to complete the process of unstaking

This function first checks the time period is complete or not, if its completed then the calculated price (`totalNFTs * Reward (in %)`) in the form of `Warcoin` are send to the NFT staker address.
