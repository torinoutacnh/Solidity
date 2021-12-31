// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract ERC20Contract is ERC20, Ownable  {
    uint256 public maxSupply = 100000 * 10**18;

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // Mint 100 tokens to msg.sender
        // Similar to how
        // 1 dollar = 100 cents
        // 1 token = 1 * (10 ** decimals)
        _mint(msg.sender, maxSupply);
    }

    function transferToAccount(
        address to,
        uint256 amount,
        bool completedTime
    ) public onlyOwner {
        require(completedTime == true);
        _mint(to, amount);
    }

    function approveNFTContract(address _tokenAddress) public onlyOwner {
        approve(_tokenAddress, maxSupply);
    }
}