pragma solidity ^0.8.0;


// SECURITY PATTERN : CHECKS - EFFECTS - INTERACTIONS

contract bank { // UNSAFE
    
    mapping(address => uint) balance;
    
    function withdraw() public {
        require(balance[msg.sender] > 0); //checks
        msg.sender.send(balance[msg.sender]); // interaction
        balance[msg.sender] = 0; // effects
    }
    
}

contract attact {
    
    function start() public {
        // deposit fund to bank
        // call to withdraw()
    }
    
    // call with no calldata + value
    receive() external payable {
        // new call to withdraw
    }
    
    // when no other function matches
    fallback() external payable {
        
    }
    
}