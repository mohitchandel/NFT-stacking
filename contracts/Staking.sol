// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./WarWeapon.sol";
import "./Warcoin.sol";

contract Staking {

    WarWeapon public nftToken;
    Warcoin public rewardToken;
    uint256 public endTime;
    uint256 rewardPrice;

    event nftStaked(address indexed _from, uint256 _tokenId, uint256 _amount);
    event nftUnstaked(address indexed _from);

    struct Stake {
        uint256 tokenId;
        uint256 amount;
        uint256 fromTime;
        uint256 toTime;
        uint256 months;
    }
    mapping(address => Stake) public staked;

    constructor(WarWeapon _nftaddress, Warcoin _rewardToken){
        nftToken = _nftaddress;
        rewardToken = _rewardToken;
    }

    // Function to stake token (where _months should be 1, 6 or 12)
    function stakeNFTToken(uint256 _tokenId, uint256 _amount, uint16 _months) public{
        endTime = block.timestamp + (30 days * _months);
        staked[msg.sender] = Stake(_tokenId, _amount, block.timestamp, endTime, _months);
        nftToken.safeTransferFrom(msg.sender, address(this), _tokenId, _amount, "");
    }

    // Function to unstake nft and recieve reward token
    function unstakeNFTToken() public payable{
        require(staked[msg.sender].amount > 0, "You don't have any NFT stacked");
        require(staked[msg.sender].toTime < endTime, "Not allowed to unstacke before time");
        calculatedPrice(staked[msg.sender].months);
        rewardToken.mint(msg.sender, rewardPrice);
        delete staked[msg.sender];
        emit nftUnstaked(msg.sender);
    }

    // Calculate reward price
    function calculatedPrice(uint256 _months) internal {
        uint16 basicPercent;
        if (_months == 1){
            basicPercent = 5;
        }else if(_months == 6){
            basicPercent = 10;
        }else{
            basicPercent = 15;
        }
        rewardPrice = (staked[msg.sender].amount *  basicPercent) * 10 ** 18 ;
    }


    // Function to make contract eligible to store ERC1155 standarde token
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4) {
        return bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"));
    }

}