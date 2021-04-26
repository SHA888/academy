pragma solidity 0.8.0;

contract c {
    
    uint[] storageArray; // storage
    
    // Assign by copy
    // Assign by reference / pointer
    
    function f(uint[] memory memoryArray) public {
        storageArray = memoryArray; // in memory => copy memoryArray to storageArray
    }
}