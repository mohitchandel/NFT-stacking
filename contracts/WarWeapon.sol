// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract WarWeapon is ERC1155, Ownable, ERC1155Burnable {
    uint256 public constant gun = 0;
    uint256 public constant knife = 1;
    uint256 public constant sword = 10;

    constructor() ERC1155("https://gtagame.example/api/item/{id}.json") {
        _mint(msg.sender, gun, 2, "");
        _mint(msg.sender, sword, 10, "");
        _mint(msg.sender, knife, 20, "");
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
}