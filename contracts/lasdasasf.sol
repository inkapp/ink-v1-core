//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.7;

contract LASDASADF {
    struct Post {
        address poster;
        string description;
        uint id;
    }
    
    uint public flexId;
    mapping (uint => Post) public flexes;
    
    function createFlex (string memory _description) public {
        flexes[flexId] = Post(msg.sender, _description, flexId);
        flexId++;
    }
    
    
}
