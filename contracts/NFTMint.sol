// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTMint is  
    Ownable, 
    ERC721URIStorage
{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 public _price = 0;
 
    constructor() ERC721("NFTMintContract", "NFT"){}

    modifier onlyAccounts () {
        require(msg.sender == tx.origin, "Not allowed origin");
        _;
    }

    function setPrice(uint256 price) external payable onlyOwner {
       _price = price;
    }

    function makeAnEpicNFT(string memory nftdata, address payable _to)  external payable onlyAccounts {
        (bool success,) = _to.call{value: _price}("");
        if (!success) {
            revert("Failed to send ETH");
        }
        // Get the current tokenId, this starts at 0.
        _tokenIds.increment();
            uint256 tokenId = _tokenIds.current();
        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, tokenId);

        // Set the NFTs data.
        _setTokenURI(tokenId, nftdata);
    }


    function totalSupply() public view returns (uint) {
        return _tokenIds.current();
    }

}






