pragma solidity 0.7.5;
pragma abicoder v2;

contract Gastest {
    
    function testExternal(uint[] calldata numbers) external returns (uint) {
        return numbers[0];
    }
    
    function testPublic(uint[] memory numbers) public returns (uint) {
        return numbers[0];
    }
    
}