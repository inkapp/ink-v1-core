//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract ink {
    
    struct Post {
        address poster;
        string content;
        uint timePosted;
    }

    struct User {
        address user;
        mapping(address=>bool) activeFollowers;
        mapping(address=>bool) activeFollows;
        address[] followers;
        Post[] posts;
    }
    uint postId = 0;
    uint userId = 0;
    
    mapping (uint => User) userIndex;
    mapping(uint=>Post) postIndex;
    mapping(address=>uint) userProf;
    //mapping (address => address[]) followers;
    //mapping (address => address[]) following;
    //uint postId;

    modifier validUser(address _user){
        require(userIndex[userProf[_user]].user!=address(0),"User not registered");
        _;
    }

    modifier notUser(address _user) {
        require(userIndex[userProf[_user]].user==address(0),"User already registered");
        _;
    }

    modifier notAFollower(address toFollow,address _follower){
        require(!userIndex[userProf[toFollow]].activeFollowers[_follower],"You are already following this user");
        _;
    }

    function register() public notUser(msg.sender){
        User storage u = userIndex[userId];
        u.user = msg.sender;
        userProf[msg.sender] = userId;
        userId++;
    }
    

    function createPost (string memory _content) public validUser(msg.sender) {
        Post storage p = postIndex[postId];
        p.poster = msg.sender;
        p.content = _content;
        p.timePosted = block.timestamp;
        userIndex[userProf[msg.sender]].posts.push(p);
        postId++;
    }
    
    function followUser(address _toFollow) public validUser(msg.sender) validUser(_toFollow) notAFollower(_toFollow,msg.sender) {
        require(_toFollow!= msg.sender, "you can't follow yourself.");   
        userIndex[userProf[_toFollow]].activeFollowers[msg.sender] = true;
        userIndex[userProf[_toFollow]].followers.push(msg.sender);
    }
    
    function getFollowers(address _user) public validUser(_user) view returns (uint) {
        return userIndex[userProf[_user]].followers.length;
    }
    
}
