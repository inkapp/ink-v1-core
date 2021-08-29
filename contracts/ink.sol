//SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
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
        uint256 tips;
        Post[] posts;
    }
    
    uint postId = 0;
    uint userId = 0;
    //30% burn fee while tipping
    uint burnFee= 30;
    IERC20 inkToken;
    address public treasury;
    mapping (uint => User) userIndex;
    mapping(uint => Post) postIndex;
    mapping(address => uint) userProf;
    //mapping (address => address[]) followers;
    //mapping (address => address[]) following;
    //uint postId;
    event Tipped(address indexed _from,address indexed _to,uint amount);

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
    constructor(address _inkToken,address _treasury) {
inkToken=IERC20(_inkToken);
treasury=_treasury;
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

    function getUserPosts(address _user) public view validUser(_user) returns(Post[] memory ){
return userIndex[userProf[_user]].posts;
    }
    
    function getPost(uint _postId) public view returns(Post memory){
        return postIndex[_postId];
    }
    //burn tokens while tipping
    function tipUser(address _user,uint _amount) public validUser(msg.sender) validUser(_user){
        require(msg.sender != _user, "can't tip yourself!");
        uint toSend=_amount-((burnFee*_amount)/100);
        uint toTreasury=_amount-toSend;
        require(inkToken.transferFrom(msg.sender, treasury, toTreasury));
        require(inkToken.transferFrom(msg.sender, _user, toSend));
        emit Tipped(msg.sender, _user, _amount);
    }
    
}
