// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./ERC721Holder.sol";

contract NFTContract is ERC721URIStorage, ERC721Enumerable, ERC721Holder, ReentrancyGuard, Ownable   {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    event BalanceChange(address from,uint256 value,uint256 balance);
    event PaymentIn(address from, uint256 value);
    event Response(bool success, bytes data);
    
    constructor() ERC721("BiNT", "ITM") {}

    fallback() external payable {
    }
    
    receive() external payable {
        emit BalanceChange(msg.sender, uint256(msg.value), address(this).balance);
        emit PaymentIn(msg.sender, msg.value);
    }

    function Mint(address to, string memory _tokenURI)
        public
        payable
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(to, newItemId);
        _setTokenURI(newItemId, _tokenURI);

        return newItemId;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function safeMint(address to, uint256 tokenId) public payable onlyOwner {
        _safeMint(to, tokenId);
    }

    function addressBalance() public onlyOwner view returns(uint256 balance){
        return address(this).balance;
    }
    
    function transferNFT(address from, address to, uint256 tokenId) 
        external 
        payable 
        returns(address toAddress)
    {
        _transfer(from, to, tokenId);
        return to;
    }

    function transferMoney(address payable to) 
        public 
        payable 
    {
        //payable(to).transfer(SafeMath.add(msg.value,amount));
        require(0 < msg.value,"Amount is not right");
        require(balanceOf(msg.sender) > msg.value,"Balance not enough");
        require(to != address(0x0),"Input is not address");
        require(to!=msg.sender);
        (bool success, bytes memory data) = payable(to).call{value: msg.value, gas: 5000}('');
        emit Response(success, data);
    }
}