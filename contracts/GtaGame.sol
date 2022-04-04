// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract GtaGame is ERC1155, Ownable, ERC1155Burnable {
    
    uint256 public constant bike = 0;
    uint256 public constant car = 10;


    constructor() ERC1155("https://gtagame.example/api/item/{id}.json") {
        _mint(msg.sender, bike, 5, "");
        _mint(msg.sender, car, 2, "");
    }


    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }
}