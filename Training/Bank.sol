// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;
pragma abicoder v2;
import "./Ownable.sol";
import { SafeMath }  from "./safemath.sol";

contract Bank is Ownable {
    
    mapping(address => uint256) balance;
    address[] customers;
    
    event depositDone(uint256 amount, address indexed depositedTo);
    
    function deposit() public payable returns (uint256)  {
        balance[msg.sender] = balance[msg.value].add(msg.value);
        emit depositDone(msg.value, msg.sender);
        return balance[msg.sender];
    }
    
    function withdraw(uint256 amount) public onlyOwner returns (uint256){
        require(balance[msg.sender] >= amount);
        balance[msg.sender] = balance[msg.sender].sub(amount);
        payable(msg.sender).transfer(amount);
        return balance[msg.sender];
    }
    
    function getBalance() public view returns (uint256){
        return balance[msg.sender];
    }
    
    function transfer(address recipient, uint256 amount) public {
        require(balance[msg.sender] >= amount, "Balance not sufficient");
        require(msg.sender != recipient, "Don't transfer money to yourself");
        
        _transfer(msg.sender, recipient, amount);
        
        assert(balance[msg.sender] == balance[msg.sender].sub(amount);
    }
    
    function _transfer(address from, address to, uint256 amount) private {
        balance[from] = balance[from].sub(amount);
        balance[to] = balance[to].add(amount);
    }
    
}