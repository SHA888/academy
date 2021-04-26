// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.5;

contract MultiSigWallet {
    
    event Deposit(address indexed sender, uint amount, uint balance);
    
    event SubmitTransaction(
        address indexed owner,
        uint indexed txID,
        address indexed to,
        uint value,
        bytes data
    );
    
    event ApproveTransaction(address indexed owner, uint indexed txID);
    
    event ExecuteTransaction(address indexed owner, uint indexed txID);
    
    address[] public owners;
    
    mapping(address => bool) public isOwner;
    
    uint public limitRequired;
    
    struct Transfer {
        address to;
        uint value;
        bytes data;
        bool executed;
        mapping(address => bool) isConfirmed;
        uint limit;
    }
    
    Transfer[] public transferRequest;
    
    constructor(address[] memory _owners, uint _limitRequired) public {
        require(_owners.length > 0, "owners required");
        require(_limitRequired > 0 && _limitRequired <= _owners.length);
        
        for (uint i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner is not unique");
            
            isOwner[owner] = true;
            owners.push(owner);
        }
        
        limitRequired = _limitRequired;
    }
    
    function deposit() payable external {
        emit Deposit(msg.sender, msg.value, address(this).balance);
        
    }
    
    modifier onlyOwner() {
        require(isOwner[msg.sender], "now owner");
        _;
    }
    
    function submitTransaction(address _to, uint _value, bytes memory _data) public onlyOwner {
        uint txID = transferRequest.length;
        
        transferRequest.push(Transfer({
            to: _to,
            value: _value,
            data: _data,
            executed: false,
            limit: 0
        }));
        
        emit SubmitTransaction(msg.sender, txID, _to, _value, _data);
    }
    
    modifier txExists(_txID) {
        require(_txID < transferRequest.length, "tx does not exist");
        _;
    }
    
    modifier notExecuted(_txID) {
        require(!transferRequest[_txID].executed, "tx already executed");
    }
    
    modifier notConfirmed(_txID) {
        require(!transferRequest[_txID].isConfirmed[msg.sender], "tx already confirmed");
    }
    
    function approveTransaction(uint txID) public onlyOwner txExists(_txID) notExecuted(_txID) notConfirmed(_txID) {
        Transfer storage transfer = transferRequest[_txID];
        
        transfer.isConfirmed[msg.sender] = true;
        transfer.limit += 1;
        
        emit ApproveTransaction(msg.sender, _txID);
    }
    
    function executeTransaction(uint _txID) public onlyOwner txExists(_txID) notExecuted(_txID) {
        Transfer storage transfer = transferRequest[_txID];
        
        require(transfer.limit >= limitRequired, "can not execute transfer");
        
        transfer.executed = true;
        
        (bool success, ) = transfer.to.call.value(transfer.value)(transfer.data);
        require(success, "tx failed");
        
        emit ExecuteTransaction(msg.sender, _txID);
    }
    
}