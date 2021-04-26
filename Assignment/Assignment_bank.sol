// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;
pragma abicoder v2;
import "./Ownable.sol";

contract onlyMapping {
    
    struct Entity {
        uint data;
        address _address;
        
    }
    
    mapping(address => bool) 
    
    function addEntity() public returns () {
        
    }
    
    function updateEntity() public returns () {
        
    }
    
}

contract onlyArray {
    
    
    struct Entity {
        uint data;
        address _address;
    }
    
    Entity[] public entities;
    
    function addEntity() public returns () {
        
    }
    
    function updateEntity() public returns () {
        
    }
    
}