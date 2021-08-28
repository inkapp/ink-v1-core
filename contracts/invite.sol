//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract invite {
    
    //can't claim tokens more than once per address
    mapping (address => bool) public claimed;
    mapping (address => bool) public invited;
    
    function claimToken() public {
        //send token to user
        //
        claimed[msg.sender] = true;
    }
    
    function inviteUser(address _invite1, address _invite2) public {
        require(ink.balanceOf(user) > 0)
        invited[_invite1] = true;
        invited[_invite2] = true;
    }
    
}
