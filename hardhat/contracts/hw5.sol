// SPDX-License-Identifier: GPL-3.0 

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/** 
 * @title VolcanoCoin
 * @dev hw5
 */
 
 //0xf8e81D47203A594245E36C48e151709F0C19fBe8
 contract VolcanoCoin is ERC20, Ownable {
    
    constructor() ERC20("VolcanoCoin", "VOL") {
        _mint(msg.sender, 10000);

    }

    struct Payment { 
        address recipient;
        uint amount; 
    }
    
    Payment[] public payments_record;
    mapping(address => Payment[]) public payments_records;
    
    event Supply_increase(uint);
    function increaseSupply(uint256 increaseAmount) public onlyOwner {
        _mint(msg.sender, increaseAmount);
        emit Supply_increase(increaseAmount);
    }

    event Transfer(address, uint);
    function recordPayment(address sender, address recipient, uint amount) public onlyOwner {
        transferFrom(sender, recipient, amount);
        emit Transfer(recipient, amount);
        payments_record.push(Payment({recipient:recipient,amount:amount}));
   }

  
}
