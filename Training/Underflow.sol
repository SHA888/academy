pragma solidity 0.5.12;

contract underflow {
    
    uint8 n = 0;
    
    function add() public returns (uint8) {
        n = n + 1;
        return n;
    }
    
    function substract() public returns (uint8) {
        n = n -1;
        return n;
    }
    
}