//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract ink {
    
    struct Post {
        uint id;
        address poster;
        string content;
        uint256 timePosted;
    }
    
    mapping (uint => Post) posts;
    mapping (address => address[]) followers;
    mapping (address => address[]) following;
    uint postId;
    
    function createPost (string memory _content) public {
        uint256 currentTime;
        currentTime == block.timestamp;
        posts[postId] = Post(postId, msg.sender, _content, currentTime);
        postId++;
    }
    
    function followUser(address _followed) public {
        require(msg.sender != _followed, "you can't follow yourself.");
        followers[_followed].push(msg.sender);
        following[msg.sender].push(_followed);
    }
    
    function postAmount() public view returns (uint) {
        return postId;
    }
    
}
