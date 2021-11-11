// SPDX-License-Identifier: UNLICENSED 

pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title VolcanoCoin
 * @dev hw3
 */
contract VolcanoCoin {
    uint totalSupply = 10000;
    address owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        if (msg.sender == owner) {
            _;
        }
    }
    
    function getSupply() public returns (uint) {
        return totalSupply;
    }
    
    event Supply_increase(uint);
    function increaseSupply() public onlyOwner {
        totalSupply+=1000;
        emit Supply_increase(totalSupply);
    }
}
