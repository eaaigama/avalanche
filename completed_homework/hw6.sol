// SPDX-License-Identifier: GPL-3.0 

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.3/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.3/contracts/access/Ownable.sol";

/** 
 * @title VolcanoNFT
 * @dev h6
 */
  
 contract VolcanoNFT is ERC721, Ownable {
    
    uint256 id = 1; 
    mapping(address => TokenMetadata[]) public tokenCatalog;
    
    struct TokenMetadata { 
        uint256 timestamp;
        uint256 id;
        string tokenURI;
    }

    constructor(string memory name, string memory symbol) ERC21(name, symbol) {}
     
    function mint() public {
        super._safemint(msg.sender, id);
        TokenMetadata memory newTokenMetadata =
            TokenMetadata(block.timestamp, id, "New token URI.");
            tokenCatalog[msg.sender].push(newTokenMetadata);
            id++;
    }
   
    function burn(uint256 _id) public {
        require(super.ownerOf(_id) == msg.sender);
        super._burn(_id);
        _deleteToken(_id);
    }
    
    function _deleteToken(uint256 _id) internal {
        TokenMetadata[] memory userTokens = tokenCatalog[msg.sender];
        delete tokenCatalog[msg.sender];

        for (uint i=0; i < userTokens.length; i++) { 
            if(userTokens[i].tokenId != _id)
            {
                tokenCatalog[msg.sender].push(userTokens[i]);
            }
        }
    }
     function _getTokenURI(uint256 _id) internal view returns (string memory) {
        TokenMetadata[] memory userTokens = tokenCatalog[msg.sender];

        for (uint i=0; i < userTokens.length; i++) { 
            if(userTokens[i].tokenId == _id)
            {
                return userTokens[i].tokenURI;
            }
        }

        revert("Token not found");
    }

    
     function tokenURI(uint256 _id) public view override returns (string memory) {
        return _getTokenURI(_id);
    }

}

