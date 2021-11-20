// SPDX-License-Identifier: UNLICENSED 

/** 
 * @title VolcanoCoin
 * @dev hw4
 */
 
contract VolcanoCoin {
    
    uint totalSupply = 10000;
    address owner;
    mapping(address => uint) balance;
    
    constructor() {
        owner = msg.sender;
        balance[owner] = totalSupply;
        totalSupply = 0;
    }

    struct Payment { 
        address recipient;
        uint amount; 
    }
    
    Payment[] public transfers;
    mapping(address => Payment[]) public userPayments;
    
    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }
    
    function getSupply() public view returns (uint) {
        return totalSupply;
    }
    
    event Supply_increase(uint);
    function increaseSupply() public onlyOwner {
        totalSupply+=1000;
        emit Supply_increase(totalSupply);
    }

   event Transfer(address, uint);
   function transfer(address recipient, uint amount) public onlyOwner {
        uint newOwnerBalance = balance[owner] - amount;
        uint newRecipientBalance = balance[recipient] + amount;
        balance[recipient] = newRecipientBalance;
        balance[owner] = newOwnerBalance;
        emit Transfer(recipient, amount);
        transfers.push(Payment({recipient:recipient,amount:amount}));
   } 


}

