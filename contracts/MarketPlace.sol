// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./NFTContract.sol";
import "./ERC20Contract.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MarketPlace {
    address private _nftOperator;
    address private _tokenOperator;

    constructor(address nft,address token){
        _nftOperator = nft;
        _tokenOperator = token;
    }

    function getNFTTotal() external {
        IERC721 cont = IERC721(_nftOperator);
        cont.setApprovalForAll(address(this),true);
    }
}