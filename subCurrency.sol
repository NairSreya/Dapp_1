// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

//we want the contract to only allow the creator to create the coins
//you only need ethereum keypair to send and receive coins without actually loging in or not
contract Coin{
    address public minter;
    mapping(address=>uint) public balance;

    event Sent(address from,address to,uint amount);
     
    constructor(){
        minter = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balance[receiver]+=amount;
    }

    error insufficientBalance(uint requested,uint available);

    function send(address receiver, uint amount) public {
    if (amount > balance[msg.sender]) {
        revert insufficientBalance({
            requested: amount,
            available: balance[msg.sender]
        });
    }

    balance[msg.sender] -= amount;
    balance[receiver] += amount;
    emit Sent(msg.sender, receiver,amount);
    }


}