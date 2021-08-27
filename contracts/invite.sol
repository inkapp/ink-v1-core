//SPDX-License-Identifier: minutes

pragma solidity ^0.8.1;

contract invite {
    
    //can't claim tokens more than once per address
    mapping (address => bool) claimed;
    
    function claimToken() public {
        //send token to user
        //
        claimed[msg.sender] = true;
    }
    
    function inviteUser() public {
        
    }
    
}
