// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BatteryPassport is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    struct Battery {
        string batteryId;
        uint256 healthScore;
        string status;
    }

    mapping(uint256 => Battery) public batteries;

    constructor() ERC721("BatteryPassport", "BATT") Ownable(msg.sender) {}

    function mintBatteryNFT(
        address to,
        string memory _batteryId,
        uint256 _healthScore,
        string memory _status,
        string memory _tokenURI
    ) public onlyOwner {
        uint256 tokenId = nextTokenId;

        _safeMint(to, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        batteries[tokenId] = Battery(_batteryId, _healthScore, _status);
        nextTokenId++;
    }

    function updateBatteryHealth(uint256 tokenId, uint256 newHealth) public onlyOwner {
        _requireOwned(tokenId);
        batteries[tokenId].healthScore = newHealth;
    }

    function updateBatteryStatus(uint256 tokenId, string memory newStatus) public onlyOwner {
        _requireOwned(tokenId);
        batteries[tokenId].status = newStatus;
    }

    function updateBatteryMetadata(uint256 tokenId, string memory newTokenURI) public onlyOwner {
        _requireOwned(tokenId);
        _setTokenURI(tokenId, newTokenURI);
    }

    function burnBatteryNFT(uint256 tokenId) public onlyOwner {
        _burn(tokenId);
        delete batteries[tokenId];
    }
}