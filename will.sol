// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
contract Will{
    address owner;
    uint256 fortune;
    bool deceased;
    //constructor
    constructor() payable {
        owner = msg.sender;// msg sender represents address that is being called
        fortune = msg.value;//msg value tells us how much ether is being sent
        deceased =  false;
    }
    //modifier
    //create modifier so that the only person who can call the contract is the owner
    modifier onlyOwner{
        require(msg.sender == owner);
        _;//imp
    }
    //create modifier so that the funds are allocated only when the person is deceased
    modifier mustBeDeceased{
        require(deceased == true);
        _;//imp
    }
    address payable[] familyWallets;
    // address payable means we can send and receive ethers // [] means its an array//familyWallets is the name
    mapping(address=>uint) inheritance; 
    
    function setInheritance(address payable wallet,uint amount) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;

    }

    function payout() private mustBeDeceased{
        for(uint i=0;i<familyWallets.length;i++){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
            //transferring the funds from the contract address to reciever address

        }
    }

    //oracle switch simulation
    function hasDeceased() public onlyOwner{
        deceased = true;
        payout();
    }
}