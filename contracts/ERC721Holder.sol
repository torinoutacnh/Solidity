// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract ERC721Holder is IERC721Receiver {
  function onERC721Received(
    address,
    address,
    uint256,
    bytes memory
  )
    public override pure
    returns(bytes4)
  {
    return this.onERC721Received.selector;
  }
}