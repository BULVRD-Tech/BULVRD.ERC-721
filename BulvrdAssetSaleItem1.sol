pragma solidity ^0.4.21;

import "./TradeableERC721Token.sol";
import "./BulvrdAsset1.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract BulvrdAssetSaleItem1 is TradeableERC721Token {
    address nftAddress;

    constructor(address _proxyRegistryAddress) TradeableERC721Token("BulvrdAsset1", "BLVDA1", _proxyRegistryAddress) public {
       
        nftAddress = new BulvrdAsset1(_proxyRegistryAddress);
    }

    function unpack(uint256 _tokenId) public {
        require(ownerOf(_tokenId) == msg.sender);
    
        // Mint the ERC721 item(s).
        BulvrdAsset1 blvdAsset = BulvrdAsset1(nftAddress);
        
        // TODO: properly generate the metadata URL
        blvdAsset.mintTo(msg.sender, "https://s3.amazonaws.com/bulvrdapp.com/assets/bulvrd_0.json");
        
        // TODO: Custom logic for configuring the item (include your randomness here!)

        // Burn the presale item.
        _burn(msg.sender, _tokenId);
    }
}