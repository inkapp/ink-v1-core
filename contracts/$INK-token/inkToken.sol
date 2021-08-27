pragma solidity ^0.8.1;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract InkToken is ERC20,Ownable{

constructor() ERC20('InkToken','INK', 1000000 *10** 18){

}


}