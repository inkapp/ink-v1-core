//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Ink {
    
    struct Post {
        uint id;
        address poster;
        string content;
        uint256 timePosted;
    }
    
    mapping (uint => Post) posts;
    uint postId;
    
    function createPost (string memory _content) public {
        uint256 currentTime;
        currentTime == block.timestamp;
        posts[postId] = Post(postId, msg.sender, _content, currentTime);
        postId++;
    }
    
    function postAmount() public view returns (uint) {
        return postId;
    }
    
}
