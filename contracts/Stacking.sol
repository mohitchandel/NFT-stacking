// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./GtaGame.sol";
import "./GtaReward.sol";

contract Stacking {

    GtaGame public nftToken;
    GtaReward public rewardToken;

    event nftStaked(address indexed _from, uint256 _tokenId, uint256 _amount);
    event nftUnstaked(address indexed _from);

    struct Stake {
        uint256 tokenId;
        uint256 amount;
        uint256 time;
    }

    mapping(address => Stake) public staked;

    constructor(GtaGame _nftaddress, GtaReward _rewardToken){
        nftToken = _nftaddress;
        rewardToken = _rewardToken;
    }

    function stakeNFTToken(uint256 _tokenId, uint256 _amount) public{
        staked[msg.sender] = Stake(_tokenId, _amount, block.timestamp);
    }

    function unstakeNFTToken() public{
        require(staked[msg.sender].amount > 0, "You don't have any NFT stacked");
        emit nftUnstaked(msg.sender);
    }

}