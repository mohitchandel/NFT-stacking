// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Warcoin is ERC20, ERC20Burnable {
    constructor() ERC20("GtaReward", "GTR") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}