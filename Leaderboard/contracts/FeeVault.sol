// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FeeVault {
    address public owner;  

    
    constructor() {
        owner = msg.sender;
    }

    
    function deposit() external payable {
        
    }

    
    function withdraw(uint amount) external {
        
        require(msg.sender == owner, "Voce nao e o dono");
        
        
        payable(owner).transfer(amount);
    }

    
    function checkBalance() external view returns (uint) {
        return address(this).balance;  // Retorna o saldo do contrato
    }
}

