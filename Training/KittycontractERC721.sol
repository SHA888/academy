pragma solidity 0.8.0;

contract Kittycontract {
    
    string public constant name = "KresnaKitties";
    string public constant symbol = "KK";
    
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    
    event Birth(
        address owner,
        uint256 kittenId,
        uint256 mumId,
        uint256 dadId,
        uint256 genes
    );
    
    struct Kitty {
        uint256 genes;
        uint64 birthTime;
        uint32 mumId;
        uint32 dadId;
        uint16 generation;
    }
    
    Kitty[] kitties;
    
    mapping (uint256 => address) public kittyIndexToOwner;
    
    mapping (address => uint256) ownershipTokenCount;
    
    function balanceOf(address owner) external view returns (uint256 balance) {
        return ownershipTokenCount[owner];
    }
    
    function 
    
}